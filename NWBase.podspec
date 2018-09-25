
Pod::Spec.new do |s|

  s.name          = "NWBase"
  s.version       = "1.0"
  s.summary       = "NWBaseProject"
  s.description   = "集成工作中的一些基类，自己用于项目的快速搭建."
  s.homepage      = "https://github.com/RITL/NWBaseProject"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.authors       = { "YueXiaoWen" => "yuexiaowen108@gmail.com" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/RITL/NWBaseProject.git", :tag => "#{s.version}" }
  s.source_files  = "Base/NWBase.h"
  s.frameworks    = "Foundation","UIKit"
  s.requires_arc  = true
  s.dependency 'RITLKit'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'SDWebImage'
  s.dependency 'UIDeviceIdentifier'


  s.subspec 'Cell' do |ss|
    ss.source_files = 'RITLPhotos/RITLConfig/*.{h,m}'
  end

  s.subspec 'API' do |ss|
    ss.source_files = 'RITLPhotos/Protocol/*.{h,m}'
  end

  s.subspec 'View_Controller' do |ss|
    ss.source_files = 'RITLPhotos/RITLPhotosCategory/*.{h,m}'
  end

end
