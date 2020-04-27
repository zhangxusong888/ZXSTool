#
# Be sure to run `pod lib lint ZXSTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZXSTool'
  s.version          = '0.2.2'
  s.summary          = '一些常用的工具类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  版本 0.2.1    添加省市区选择组件ZXSAreaSelector；
  版本 0.2.2    添加省市区选择组件的Demo程序；
                       DESC

  s.homepage         = 'https://github.com/zhangxusong888'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zxs' => 'zhangxusong888@163.com' }
  s.source           = { :git => 'https://github.com/zhangxusong888/ZXSTool.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.jianshu.com/u/5400215b7272'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ZXSTool/Classes/**/*'
  
  s.resource_bundles = {
     'ZXSTool' => ['ZXSTool/Assets/**/*']
  }

  s.public_header_files = 'ZXSTool/Classes/ZXSTool.h, ZXSAreaSelector.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
