source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "10.0"

inhibit_all_warnings!
use_frameworks!

def import_common_pods
  pod 'Alamofire'
  pod 'AlamofireObjectMapper'
  pod 'ObjectMapper'
  pod 'KVNProgress'
  pod 'MMDrawerController'
  pod 'KeychainAccess'
  pod 'HTAutocompleteTextField'
  pod 'IQKeyboardManager'
	pod 'ALCameraViewController'
	pod 'Firebase'
	pod 'Firebase/Messaging'
	pod 'Firebase/Auth'
	pod 'Firebase/Database'
  pod 'Charts'
end

target 'CommonMoney' do
  import_common_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
