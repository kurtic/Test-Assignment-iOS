# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CardTestApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for CardTestApp

  # Code generation
  pod 'R.swift', '~> 6.0'

  #Reactive
  pod 'ReactiveCocoa', '~> 10.1.0'

  # Utils
  pod 'KeychainAccess'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      end
  end
  installer.pods_project.build_configurations.each do |config|
    if config.name.include?('Debug')
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings['ENABLE_TESTABILITY'] = 'YES'
    end
  end
end