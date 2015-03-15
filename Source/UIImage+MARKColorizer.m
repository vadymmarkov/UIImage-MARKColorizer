#import "UIImage+MARKColorizer.h"

@implementation UIImage (MARKColorizer)

+ (UIImage *)mark_colorizeImage:(UIImage *)image
                      withColor:(UIColor *)color
                      blendMode:(CGBlendMode)blendMode
{
    // Create context
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Drawings
    CGRect rect = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    [image drawInRect:rect];

    // Fill with color
    CGContextSetBlendMode(context, blendMode);
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);

    // Set mask
    [image drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];

    // Get image
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return colorizedImage;
}

- (UIImage *)mark_colorizedCopyWithColor:(UIColor *)color
                               blendMode:(CGBlendMode)blendMode
{
    return [UIImage mark_colorizeImage:self withColor:color blendMode:blendMode];
}

@end
