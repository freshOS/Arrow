Pod::Spec.new do |s|
  s.name             = 'Arrow'
  s.version          = "2.0.1"
  s.summary          = "Elegant JSON Parsing in Swift"
  s.homepage         = "https://github.com/s4cha/Arrow"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = 'S4cha'
  s.platform         = :ios
  s.source           = { :git => "#{s.homepage}.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://twitter.com/sachadso'
  s.source_files     = "Source/*.swift"
  s.requires_arc     = true
  s.ios.deployment_target = "8.0"
  s.description  = "Elegant Swift JSON Parsing - Stop writing boilerplate JSON parsing code and focus on your awesome App instead"
end
