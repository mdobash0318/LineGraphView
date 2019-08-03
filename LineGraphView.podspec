#
#  Be sure to run `pod spec lint LineGraphView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "LineGraphView"
  spec.version      = "1.0.2"
  spec.summary      = "create LineGraphView"
  spec.description  = "You can make a line graph"

  spec.homepage     = "https://github.com/wrench0318/LineGraphView"
  spec.author       = "Masaharu Dobashi"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.platform     = :ios
  spec.platform     = :ios, "10.0"
  spec.swift_version = '5.0'
  spec.ios.deployment_target = "10.0"


  spec.source       = { :git => "https://github.com/wrench0318/LineGraphView.git", :tag => "v#{spec.version}" }


  spec.source_files  = "LineGraphView/**/*.{swift,h,m}"

end
