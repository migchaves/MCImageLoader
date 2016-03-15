#
# Be sure to run `pod lib lint MCImageLoader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MCImageLoader"
  s.version          = "1.0.0"
  s.summary          = "MCImageLoader loads asynchronously an UIImage to an UIImageView."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
This library loads an UIImage to a UIImageView. While the image is retrieved it shows the placeholder defined by the user.
It's also possible to set the transition duration between the placeholder and the final image.
                       DESC

  s.homepage         = "https://github.com/migchaves/MCImageLoader"
  s.license          = 'MIT'
  s.author           = { "Miguel Chaves" => "mchaves.apps@gmail.com" }
  s.source           = { :git => "https://github.com/migchaves/MCImageLoader.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'MCImageLoader' => ['Pod/Assets/*.png']
  }
end
