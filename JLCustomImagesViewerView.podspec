#
# Be sure to run `pod lib lint JLCustomImagesViewerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "JLCustomImagesViewerView"
  s.version          = "0.2.0"
  s.summary          = "This is the one for you can see one or more images in a detail view where you can zoom in, zoom out and execute some other gestures"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "This is a library really simple to use where you can show 1,2,3 so how many images you want to the user where he can zoom in , out and other gestures necessary to see all details of the images"

  s.homepage         = "https://github.com/josechagas/JLCustomImagesViewerView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "José Lucas" => "chagasjoselucas@gmail.com" }
  s.source           = { :git => "https://github.com/josechagas/JLCustomImagesViewerView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pod/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'JLCustomImagesViewerView' => ['JLCustomImagesViewerView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
