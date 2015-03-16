# UIImage-MARKColorizer

[![Version](https://img.shields.io/cocoapods/v/UIImage-MARKColorizer.svg?style=flat)](http://cocoadocs.org/docsets/UIImage-MARKColorizer)
[![License](https://img.shields.io/cocoapods/l/UIImage-MARKColorizer.svg?style=flat)](http://cocoadocs.org/docsets/UIImage-MARKColorizer)
[![Platform](https://img.shields.io/cocoapods/p/UIImage-MARKColorizer.svg?style=flat)](http://cocoadocs.org/docsets/UIImage-MARKColorizer)

UIImage category for image colorizing. Uses CGBlendMode for operations with images. Check Apple documentation for more information:
https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CGContext/index.html#//apple_ref/c/tdef/CGBlendMode

Please check Demo project for a basic example on how to use UIImage-MARKColorizer.

### Demo
![Alt text](https://cloud.githubusercontent.com/assets/10529867/6666145/c7fd75b8-cbe1-11e4-88ef-3c1fc717e4f9.gif "Demo")

### Available methods
```objc
+ (UIImage *)mark_colorizeImage:(UIImage *)image
                      withColor:(UIColor *)color
                      blendMode:(CGBlendMode)blendMode;

- (UIImage *)mark_colorizedCopyWithColor:(UIColor *)color
                               blendMode:(CGBlendMode)blendMode;
```

## Usage

#### In your code
```objc
UIImage *image = [UIImage imageNamed:@"image"];
UIImage *colorizedImage = [image mark_colorizedCopyWithColor:[UIColor greenColor]
                                                   blendMode:kCGBlendModeMultiply];
// ...
UIImage *colorizedImage2 = [UIImage mark_colorizeImage:image
                                             withColor:[UIColor greenColor] blendMode:kCGBlendModeMultiply];

```

## Installation

**UIImage-MARKColorizer** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`pod 'UIImage-MARKColorizer'`

## Author

Vadym Markov, impressionwave@gmail.com

## License

**UIImage-MARKColorizer** is available under the MIT license. See the LICENSE file for more info.
