Pod::Spec.new do |spec|
  spec.name         = "FTGLazyImageView"
  spec.version      = "1.0.0"
  spec.summary      = "A Swift lazy loading UIImageView implementation"
  spec.homepage     = "https://github.com/fertolg/FTGLazyImageView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Fernando Toledo" => "fernando@ftoledo.com" }
  spec.social_media_url   = "http://twitter.com/ftoledo"
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/fertolg/FTGLazyImageView.git", :tag => spec.version.to_s }
  spec.source_files  = "Source", "Source/**/*.{h,swift}"
  spec.requires_arc = true
end
