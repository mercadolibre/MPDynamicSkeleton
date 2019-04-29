module CIHelper
    GITHUB_TOKEN = ENV['GITHUB_TOKEN']
    PULL_REQUEST = ENV['CI_PULL_REQUEST'] ? URI(ENV['CI_PULL_REQUEST']).path.split('/').last : "false"
    BUILD_DIR = ENV['CIRCLE_WORKING_DIRECTORY'] ? ENV['CIRCLE_WORKING_DIRECTORY'].gsub(/\~/, "#{ENV['HOME']}") : "#{ENV['HOME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"
    REPO_SLUG = "#{ENV['CIRCLE_PROJECT_USERNAME']}/#{ENV['CIRCLE_PROJECT_REPONAME']}"
    CHANGED_FILES_PATTERS_WHITELIST = ['.pbxproj', 'Podfile.lock']
    @@pr_info = nil # PR info from GitHub API: https://developer.github.com/v3/pulls/#get-a-single-pull-request

    # Run a given command from the ci build directory
    def self.cd_run(command)
        `cd #{CIHelper::BUILD_DIR} && #{command}`
    end

    # Checks if commit has a deploy message in it
    def self.has_deploy_message?
        CIHelper::cd_run('git log -n1 --oneline --no-merges | grep -e \'\\[ci deploy\\]\' -e \'\\[deploy ci\\]\'| wc -l').to_s().strip! != "0"
    end

    def self.spec_version
        require 'cocoapods'

        podspec_path = "#{CIHelper::BUILD_DIR}/MPDynamicSkeleton.podspec"
        spec = Pod::Specification.from_file(podspec_path)
        spec.version.to_s()
    end

    # Gets the notes of the last version (lines between tags #) in CHANGELOG.md file
    def self.get_release_notes
        changelog_path = "#{CIHelper::BUILD_DIR}/CHANGELOG.md"
        unless File.exist?(changelog_path)
            puts "Changelog was not found in expected path: '#{changelog_path}'"
            return ""
        end

        changelog = File.open(changelog_path).read
        release_notes = ""
        changelog.each_line do |line|
            if line.strip.empty?
                next
            end

            if /^#[[:blank:]]+v([[:digit:]]+\.){2}[[:digit:]]+/ =~ line
                if release_notes.empty?
                    next # Current version title
                else
                    break # Next version title
                end
            end
            release_notes += line
        end

        return release_notes
    end

    def self.get_pr_info
        unless Gem::Specification::find_all_by_name('octokit').any?
            $stderr.puts "[!] Cannot obtain PR info from GitHub. 'octokit' dependency not found"
            return nil
        end

        if @@pr_info == nil
            require "octokit"
            client = Octokit::Client.new(access_token: CIHelper::GITHUB_TOKEN)
            @@pr_info = client.pull_request(REPO_SLUG, PULL_REQUEST)
        end
        return @@pr_info
    end

    def self.get_base_branch
        if !PULL_REQUEST.to_s.empty? && PULL_REQUEST != "false"
            begin
                return get_pr_info.base.ref
            rescue Exception => e
                $stderr.puts "[!] Cannot obtain base branch name from GitHub. Error: #{e.message}"
                return nil
            end
        end
        return ENV['CIRCLE_BRANCH']
    end

    def self.is_running_in_ci?
        return ENV['CIRCLECI']=="true"
    end

    def self.is_release_branch?
        CIHelper::get_base_branch =~ /^release.*$/
    end

    # Checks if untracked changes are present in the current HEAD
    def self.has_untracked_changes?
        whitelist = CHANGED_FILES_PATTERS_WHITELIST.join(' -e ')
        CIHelper::cd_run("git status --porcelain | grep -v -e #{whitelist} | wc -l").to_s().strip! != "0"
    end

    # Gets the untracked changes of the current HEAD
    def self.untracked_changes
        whitelist = CHANGED_FILES_PATTERS_WHITELIST.join(' -e ')
        CIHelper::cd_run("git status --porcelain | grep -v -e #{whitelist}").to_s
    end

    # Checks if for a given pod the tag already exists
    def self.tag_already_exists(pod_version)
        CIHelper::cd_run('git tag').strip.split("\n").include?(pod_version)
    end

    # Checks if can deploy library as release
    def self.can_deploy_library? (version)
        errors = ''
        if not CIHelper::is_release_branch?
            errors << "[!] Deployment runs only 'release' branch\n"
        end

        # This check has mixed behaviors. We definitely should remove it from here.
        # Checks for a deploy should be done only when [ci deploy] is present, but 
        # the inexistence of it doesn't mean there is an error
        if not CIHelper::has_deploy_message?
            errors <<  "[!] To make a deployment add '[ci deploy]' anywhere in the commit message\n"
        end

        if CIHelper::has_untracked_changes?
            errors <<  "[!] Uncommitted or untracked files are detected. Please commit them and try again\n"
            errors <<  ">>> Untracked changes: " << untracked_changes
        end

        if CIHelper::tag_already_exists(version)
            errors << "[!] A tag for version #{version} already exists. Please change the version and try again\n"
        end

        if errors.length>0
            $stderr.puts errors
            return false
        end
        return true
    end
end