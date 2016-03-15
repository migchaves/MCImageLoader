# MCImageLoader

[![Version](https://img.shields.io/cocoapods/v/MCImageLoader.svg?style=flat)](http://cocoapods.org/pods/MCImageLoader)
[![License](https://img.shields.io/cocoapods/l/MCImageLoader.svg?style=flat)](http://cocoapods.org/pods/MCImageLoader)
[![Platform](https://img.shields.io/cocoapods/p/MCImageLoader.svg?style=flat)](http://cocoapods.org/pods/MCImageLoader)

## Preview

MCImageLoader allows the user to load an UIImage to a UIImageView asynchronously. 
While the image is retrieved it shows the placeholder defined by the user and an UIActivityIndicatorView.
It's also possible to set the transition duration between the placeholder and the final image.

<img src="https://github.com/migchaves/MCImageLoader/blob/master/Pod/Assets/imageloader.gif" alt="Overview" />

## Usage

Simple usage:

```ruby
import MCImageLoader
```

Configure (if you do not want to use the default values):

```
MCImageLoader.sharedInstance.usesFastCache = true
MCImageLoader.sharedInstance.fastCacheCapacity = 10
MCImageLoader.sharedInstance.animationDuration = 0.8
```

Load an image with placeholder:

```ruby
MCImageLoader.sharedInstance.loadImage(imageUrl,
imageView: imageView,
placeHolder: placeholder)
```

## Requirements

iOS 8.+

## Installation

MCImageLoader is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MCImageLoader", '~> 1.0.0'
```

## Author

Miguel Chaves, mchaves.apps@gmail.com

## License

Copyright (c) 2016 Miguel Chaves <mchaves.apps@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
