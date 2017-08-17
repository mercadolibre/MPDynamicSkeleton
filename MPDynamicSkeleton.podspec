Pod::Spec.new do |s|
  s.name             = "MPDynamicSkeleton"
  s.version          = "0.1.0"
  s.summary          = "MPDynamicSkeleton - Create modilarized skeleton"
  s.homepage         = "https://github.com/mercadolibre/MPDynamicSkeleton"
  s.author           = { "Marcelo José" => "marcelo.jose@mercadolibre.com" }

  s.source           = { :git => "git@github.com:mercadolibre/MPDynamicSkeleton.git", :tag => s.version.to_s}
  s.license          = 'none'
  s.platform         = :ios, '9.0'
  s.requires_arc     = true

  s.source_files = 'Pod/Classes/**/*'

end