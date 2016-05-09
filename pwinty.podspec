Pod::Spec.new do |s|
  s.name         = "Pwinty"
  s.version      = "0.0.3"
  s.summary      = ""
  s.description  = ""
  s.homepage     = "https://github.com/karlnosworthy/pwinty_swift"
  s.license      = { :type => 'MIT' }
  s.author       = "Karl Nosworthy"

  s.platforms     = { :ios => "8.0", :tvos => "9.0" }
  s.requires_arc = true

  s.source           = { :git => "https://github.com/karlnosworthy/pwinty_swift.git", :tag => s.version.to_s }
  s.source_files     = 'Sources/*.{swift}'

  s.dependency 'Gloss'
  s.dependency 'Alamofire', '~>3.0'

end