source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target 'AppleMusic' do

  pod 'SnapKit', '~> 3.0.2'
  pod 'Alamofire', '~> 4.2.0'
  pod 'SwiftyJSON', '~> 3.1.3'
  pod 'SDWebImage', '~> 4.0.0-beta2'
  
end

# Changes build active architecture only
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0' #Temporary change for migration
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
    end
  end
end
