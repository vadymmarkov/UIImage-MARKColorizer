@import UIKit;

@interface UIImage (MARKColorizer)

+ (UIImage *)mark_colorizeImage:(UIImage *)image
                      withColor:(UIColor *)color
                      blendMode:(CGBlendMode)blendMode;

- (UIImage *)mark_colorizedCopyWithColor:(UIColor *)color
                               blendMode:(CGBlendMode)blendMode;

@end
