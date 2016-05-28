# JLCustomImagesViewerView

[![CI Status](http://img.shields.io/travis/José Lucas/JLCustomImagesViewerView.svg?style=flat)](https://travis-ci.org/José Lucas/JLCustomImagesViewerView)
[![Version](https://img.shields.io/cocoapods/v/JLCustomImagesViewerView.svg?style=flat)](http://cocoapods.org/pods/JLCustomImagesViewerView)
[![License](https://img.shields.io/cocoapods/l/JLCustomImagesViewerView.svg?style=flat)](http://cocoapods.org/pods/JLCustomImagesViewerView)
[![Platform](https://img.shields.io/cocoapods/p/JLCustomImagesViewerView.svg?style=flat)](http://cocoapods.org/pods/JLCustomImagesViewerView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JLCustomImagesViewerView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JLCustomImagesViewerView"
```
## Images


## Using this Library
##### *First Step*

Import it on every file that you will use this framework.

```swift
import JLCustomImagesViewerView
```
##### *Second Step*
    Call this method to show the JLCustomImagesViewerView with the images you want

- parameter images: Array of images that you want to see
- parameter view: The view where you want to show it
- parameter showViewCompletion: A block that will be executed after present the JLCustomImagesViewerView
- parameter hideViewCompletion: A block that will be executed after remove the JLCustomImagesViewerView

```swift
public func showViewerForImages(images:[UIImage],OnView view:UIView,showViewCompletion:(()->())?,hideViewCompletion:(()->())?) {
```
#### *That's it, now you are ready to use it*


## Author

José Lucas, chagasjoselucas@gmail.com

## License

JLCustomImagesViewerView is available under the MIT license. See the LICENSE file for more info.
