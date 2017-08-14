task :release, [:name]  do |t, args|

  if not args.name
    $stderr.puts "[!] Pod name is required"
    exit 1
  end

  pod_name = args.name.to_s()

  puts 'Checking repo'

  if not is_master_branch?
    $stderr.puts "[!] You need to be on the 'master' branch in order to publish a release."
    exit 1
  end

  if has_untracked_changes?
    $stderr.puts "[!] Uncommitted or untracked files are detected. Please commit or stash them and try again"
    exit 1
  end

  puts 'Checking pod version'

  pod_version = spec_version(pod_name)

  if tag_already_exists(pod_version)
    $stderr.puts "[!] A tag for version #{pod_version} already exists. Change the version in the podspec"
    exit 1
  end

  puts 'Repo check complete'

  puts 'Linting podspec'

  sh "pod lib lint --allow-warnings --sources='git@github.com:mercadolibre/mpmobile-ios_specs.git,git@github.com:mercadolibre/mobile-ios_specs.git,https://github.com/CocoaPods/Specs' --verbose"

  puts 'Lint check complete'

  puts "Creating tag #{pod_version}"

  create_tag(pod_version)
  push_tag

  puts 'Tag created'

  puts 'Publishing pod'
  
  push_pod(pod_name)   
 
  puts 'Done!'
end

def is_master_branch?
  `git symbolic-ref HEAD 2>/dev/null`.strip.split('/').last == 'master'
end

def has_untracked_changes?
  `git status --porcelain|wc -l`.to_s().strip! != "0"
end

def spec_version(pod_name)
  require 'cocoapods'
  
  spec = Pod::Specification.from_file("#{pod_name}.podspec")
  spec.version.to_s()
end

def tag_already_exists(pod_version)
  `git tag`.strip.split("\n").include?(pod_version)
end

def create_tag(pod_version)
  sh "git tag #{pod_version}"
end

def push_tag
  sh 'git push origin --tags'
end

def push_pod(pod_name)
  if not `pod repo list`.strip.split("\n").include?("MPPods")
    sh 'pod repo add MPPods git@github.com:mercadolibre/mpmobile-ios_specs.git'
  end

  sh "pod repo push MPPods #{pod_name}.podspec --allow-warnings --verbose"
end