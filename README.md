# Animoji

Animoji is an iOS library that gives access to the private framework AvatarKit to generate Animoji, just like the Messages app.

```
$ pod try Animoji
```

## Requirements

- iOS 11.1
- Xcode 9.1
- Swift 4

## Usage

### Privacy Settings

You must provide a description for how your app uses the following privacy settings in your app's Info.plist file.

* NSPhotoLibraryAddUsageDescription
* NSMicrophoneUsageDescription
* NSCameraUsageDescription

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org/), simply add this in your `Podfile`:
```ruby
use_frameworks!
pod "Animoji"
```

### Carthage
To install with [Carthage](https://github.com/Carthage/Carthage), simply add this in your `Cartfile`:
```ruby
github "efremidze/Animoji"
```

## Disclaimer

Animoji utilizes Apple's private API to do its magic. Use caution, submitting this code to the App Store adds the risk of being rejected!

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Apps Using _Animoji_

Feel free to submit a PR if you’re using this library in your apps.

## License

Magnetic is available under the MIT license. See the LICENSE file for more info.
