#
# Be sure to run `pod lib lint IncredibleNetworkManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IncredibleNetworkManager'
  s.version          = '0.1.1'
  s.summary          = 'Awesome library to load JSON objects and parse them, also do download and caching images.'
  s.swift_version    = '3.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  To use the Library initialize it in the AppDelegate with the command:
  - NetworkManager.initializeNetworkManager()

  To request from the server use the method:
  - NetworkManager.shared.performRequest(_ urlString: String?,
                   method: URLMethod? = .GET,
                   bodyData: Data? = nil,
                   headerValues: [[String]]? = nil,
                   shouldCache: Bool = false,
                   completion:@escaping (_ data: Data?) -> Void,
                   timeoutAfter timeout: TimeInterval = 120,
                   onTimeout: (()->Void)? = nil) -> URLSessionDataTask?

  To load images into the chache use the method:
  - imageView.setImage(<#T##url: String?##String?#>, thumbnailUrl: <#T##String?#>, placeholder: <#T##UIImage?#>, animated: <#T##Bool#>, completion: <#T##((UIImage?) -> Void)?##((UIImage?) -> Void)?##(UIImage?) -> Void#>)
                       DESC

  s.homepage         = 'https://github.com/fghoffmann/IncredibleNetworkManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fabio Gustavo Hoffmann' => 'fabio@dogtownmedia.com' }
  s.source           = { :git => 'https://github.com/fghoffmann/IncredibleNetworkManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'IncredibleNetworkManager/{Classes,Extensions}/**/*'
  
  # s.resource_bundles = {
  #   'IncredibleNetworkManager' => ['IncredibleNetworkManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
