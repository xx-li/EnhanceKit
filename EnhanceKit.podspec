#
# Be sure to run `pod lib lint EnhanceKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EnhanceKit'
  s.version          = '0.1.0'
  s.summary          = '用于增强系统框架的能力，主要是提供一些Extension和Categorys的支持（同时包含Swift和OC）'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
用于增强系统框架的能力，主要是提供一些Extension和Categorys的支持。
类似于YYCategories，但是同时包含OC和Swift部分，以subspec的方式隔离，可以分开使用。
                       DESC

  s.homepage         = 'https://github.com/xx-li/EnhanceKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lixinxing' => 'x@devlxx.com' }
  s.source           = { :git => 'https://github.com/xx-li/EnhanceKit.git', :tag => s.version.to_s }

  s.swift_versions = '5.0'
  s.ios.deployment_target = '12.0'
  
  
  s.subspec 'Swift' do |ss|
      ss.source_files = 'EnhanceKit/Classes/Swift/**/*'
  end
  
  s.subspec 'OC' do |ss|
      ss.source_files = 'EnhanceKit/Classes/OC/**/*'
  end
  
end
