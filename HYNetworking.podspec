Pod::Spec.new do |s|

s.name         = "HYNetworking"
s.version      = "0.1.1"
s.summary      = "HYNetworking is a greate network util based on AFNetworking."
s.homepage     = "https://github.com/castial/HYNetworking"
s.license      = "MIT"
s.author             = {
"hyyy" => "liyangliyang001@gmail.com"
}
s.source        = { :git => "https://github.com/castial/HYNetworking.git", :tag => s.version.to_s }
s.source_files  = "HYNetworking"
s.platform      = :ios, '7.0'
s.requires_arc  = true
s.dependency "AFNetworking", "~> 3.0.0"

end
