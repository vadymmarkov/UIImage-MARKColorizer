Pod::Spec.new do |s|
  s.name             = "UIImage-MARKColorizer"
  s.version          = "0.1.1"
  s.summary          = "UIImage category for image colorizing"
  s.homepage         = "https://github.com/markvaldy/UIImage-MARKColorizer"
  s.license          = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author           = { "Vadym Markov" => "impressionwave@gmail.com" }
  s.social_media_url = 'https://twitter.com/markvaldy'
  s.source           = {
    :git => "https://github.com/markvaldy/UIImage-MARKColorizer.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.frameworks = 'UIKit'

  s.source_files = 'Source/**/*.{h,m}'
end
