Pod::Spec.new do |s|
  s.name             = "MPDynamicSkeleton"
  s.version          = "0.2.2"
  s.summary          = "Mercado Pago skeleton"
  s.homepage         = "https://github.com/mercadolibre/MPDynamicSkeleton"
  s.author           = { "Marcelo José" => "marcelo.jose@mercadolibre.com" }
  s.description      = "A modularized skeleton with gradient animation"

  s.source           = { :git => "https://github.com/mercadolibre/MPDynamicSkeleton.git", :tag => s.version.to_s}
  s.license          = 'Apache License, Version 2.0'
  s.platform         = :ios, '10.0'
  s.requires_arc     = true

  s.source_files = 'Pod/Classes/**/*'

  s.swift_version = '4.2'
end
