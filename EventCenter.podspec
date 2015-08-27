#
# Be sure to run `pod lib lint EventCenter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EventCenter"
  s.version          = "1.0.0"
  s.summary          = "Swift Library of Type Safe Event Notification like Android's EventBus."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                        EventCenter is a swift library like Android's EventBus.
                        Observers can register type safe handlers(no need to type casting), and unregister.
                        The handler's running thread can be specified when registering the hander.
                       DESC

  s.homepage         = "https://github.com/mokemokechicken/EventCenter"
  s.license          = 'MIT'
  s.author           = { "Ken Morishita" => "mokemokechicken@gmail.com" }
  s.source           = { :git => "https://github.com/mokemokechicken/EventCenter.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mokemokechicken'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
#  s.resource_bundles = {
#    'EventCenter' => ['Pod/Assets/*.png']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
