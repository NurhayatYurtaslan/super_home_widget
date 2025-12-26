#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint super_home_widget.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'super_home_widget'
  s.version          = '1.0.0'
  s.summary          = 'A customizable iOS home screen widget package for Flutter using Apple\'s WidgetKit framework.'
  s.description      = <<-DESC
A customizable iOS home screen widget package for Flutter using Apple's WidgetKit framework.
Supports multiple design styles including liquid glass themes.
                       DESC
  s.homepage         = 'https://github.com/nurhayatyurtaslan/super_home_widget'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nurhayat Yurtaslan' => 'your-email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
