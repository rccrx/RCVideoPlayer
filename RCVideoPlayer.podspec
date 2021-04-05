Pod::Spec.new do |spec|

  spec.name         = "RCVideoPlayer"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of RCVideoPlayer."
  spec.homepage     = "https://github.com/rccrx/RCVideoPlayer"
  spec.license      = "MIT"
  spec.author             = { "rccrx" => "rccrx@qq.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/rccrx/RCVideoPlayer.git", :tag => "#{spec.version}" }
  spec.source_files  = "RCVideoPlayer"
  spec.requires_arc = true

end
