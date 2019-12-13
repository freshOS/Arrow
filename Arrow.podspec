Pod::Spec.new do |s|
  s.name             = 'Arrow'
  s.version          = "5.1.1"
  s.summary          = "Elegant JSON Parsing in Swift"
  s.homepage         = "https://github.com/freshOS/Arrow"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = 'S4cha'
  s.platform         = :ios
  s.source           = { :git => "https://github.com/freshOS/Arrow.git",
                         :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sachadso'
  s.source_files     = "Source/*.swift"
  s.requires_arc     = true
  s.ios.deployment_target = "8.0"
  s.description  = "Elegant Swift JSON Parsing - Stop writing boilerplate JSON parsing code and focus on your awesome App instead"
  s.swift_versions = ['2', '3', '4', '4.1', '4.2', '5.0', '5.1', '5.1.3']
end
