<p align="center">
<img src="https://www.councilofnonprofits.org/tools-resources/network-approach-capacity-building" alt="Icon"/>
</p>
<H1 align="center">IncredibleNetworkManager</H1>
<p align="center">
<img src="https://img.shields.io/badge/license-MIT-green.svg"GitHub license"/>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
[![Platform iOS](https://img.shields.io/badge/Platform-iOS-blue.svg?style=fla)]()

|                        | Language | Minimum iOS Target | Minimum Xcode Version |
|------------------------|----------|--------------------|-----------------------|
| IQKeyboardManagerSwift | Swift    | iOS 8.0            | Xcode 9.0             |
| Demo Project           |          |                    | Xcode 9.0             |

## Installation

IncredibleNetworkManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'IncredibleNetworkManager'
```
## How to Use

To use the Library initialize it in the AppDelegate with the command:
```swift
@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NetworkManager.initializeNetworkManager()

        return true
    }
}
```

To request from the server use the method:
```swift
NetworkManager.shared.performRequest(_ urlString: String?,
                                    method: URLMethod? = .GET,
                                    bodyData: Data? = nil,
                                    headerValues: [[String]]? = nil,
                                    shouldCache: Bool = false,
                                    completion:@escaping (_ data: Data?) -> Void,
                                    timeoutAfter timeout: TimeInterval = 120,
                                    onTimeout: (()->Void)? = nil) -> URLSessionDataTask?
```

To load images into the chache use the method:
```swift
imageView.setImage(<#T##url: String?##String?#>, thumbnailUrl: <#T##String?#>, placeholder: <#T##UIImage?#>, animated: <#T##Bool#>, completion: <#T##((UIImage?) -> Void)?##((UIImage?) -> Void)?##(UIImage?) -> Void#>)
```

## Author

Fabio Gustavo Hoffmann, fabio@dogtownmedia.com

## License

IncredibleNetworkManager is available under the MIT license. See the LICENSE file for more info.

## Versions

### 0.1.1
    Initial Version
