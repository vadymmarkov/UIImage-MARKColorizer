#import "ViewController.h"
#import "UIColor+Demo.h"

#import <iOS-Color-Picker/FCColorPickerViewController.h>
#import "UIImage+MARKColorizer.h"

static CGFloat const kViewControllerImageViewSize = 290.0;
static CGFloat const kViewControllerButtonWidth = 120.0;
static CGFloat const kViewControllerPickerWidth = 290.0;

@interface ViewController () <FCColorPickerViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *button;
@property (nonatomic) UIPickerView *pickerView;

@property (nonatomic) UIImage *image;
@property (nonatomic) NSDictionary *blendModes;
@property (nonatomic) NSNumber *blendMode;
@property (nonatomic, copy) UIColor *color;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Additional setup after loading the view
    self.title = @"Colorizer Demo";
    self.view.backgroundColor = [UIColor backgroundColor];

    self.blendModes = @{
                        @(kCGBlendModeMultiply): @"kCGBlendModeMultiply",
                        @(kCGBlendModeColorBurn): @"kCGBlendModeColorBurn",
                        @(kCGBlendModeDarken): @"kCGBlendModeDarken",
                        @(kCGBlendModePlusDarker): @"kCGBlendModePlusDarker",
                        @(kCGBlendModeLighten): @"kCGBlendModeLighten",
                        @(kCGBlendModePlusLighter): @"kCGBlendModePlusLighter",
                        @(kCGBlendModeSoftLight): @"kCGBlendModeSoftLight",
                        @(kCGBlendModeHardLight): @"kCGBlendModeHardLight",
                        @(kCGBlendModeOverlay): @"kCGBlendModeOverlay",
                        @(kCGBlendModeHue): @"kCGBlendModeHue",
                        };

    self.blendMode = nil;
    self.color = [UIColor secondaryColor];

    [self setUpViewComponents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    CGFloat imageX = (CGRectGetWidth(self.view.frame) - kViewControllerImageViewSize) / 2;
    self.imageView.frame = CGRectMake(imageX, 90.0,
                                      kViewControllerImageViewSize, kViewControllerImageViewSize);

    CGFloat buttonX = (CGRectGetWidth(self.view.frame) - kViewControllerButtonWidth) / 2;
    self.button.frame = CGRectMake(buttonX, CGRectGetMaxY(self.imageView.frame) + 20.0,
                                   kViewControllerButtonWidth, 60.0);

    CGFloat pickerX = (CGRectGetWidth(self.view.frame) - kViewControllerPickerWidth) / 2;
    self.pickerView.frame = CGRectMake(pickerX,
                                       CGRectGetMaxY(self.button.frame) + 10.0,
                                       kViewControllerPickerWidth,
                                       CGRectGetHeight(self.pickerView.frame));
}

#pragma mark - Actions

- (void)buttonDidTouchUpInside:(UIButton *)button
{
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController
                                                colorPickerWithColor:self.color
                                                delegate:self];
    colorPicker.tintColor = [UIColor whiteColor];
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker
                       animated:YES
                     completion:nil];
}

#pragma mark - Setters

- (void)setColor:(UIColor *)color
{
    _color = [color copy];
    [self colorizeImageView];
}

#pragma mark - UI

- (void)setUpViewComponents
{
    // Image view
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imageView];

    // Button
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor secondaryColor];
    [self.button setTitle:@"Pick color" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    // Blend picker
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];

    // Load image
    NSString *urlString = [NSString stringWithFormat:@"http://lorempixel.com/%i/%i/cats", (int)kViewControllerImageViewSize, (int)kViewControllerImageViewSize];
    NSURL *url = [NSURL URLWithString:urlString];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = [UIImage imageWithData:imageData];
            [self colorizeImageView];
        });
    });
}

#pragma mark - FCColorPickerViewControllerDelegate

- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color
{
    self.color = color;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.blendModes.count + 1;
}

#pragma mark - UIPickerViewDelegate

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = @"Original";
    if (row > 0) {
        NSArray *keys = self.blendModes.allKeys;
        NSNumber *blendModeNumber = keys[row - 1];

        title = self.blendModes[blendModeNumber];
    }

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:title
                                                                           attributes:@{NSForegroundColorAttributeName:[UIColor mainTextColor]}];
    return attributedString;

}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"Original";
    }

    NSArray *keys = self.blendModes.allKeys;
    NSNumber *blendModeNumber = keys[row - 1];

    return self.blendModes[blendModeNumber];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.blendMode = row == 0 ? nil : self.blendModes.allKeys[row - 1];
    [self colorizeImageView];
}

#pragma mark - Helpers

- (void)colorizeImageView
{
    if (self.image && self.blendMode) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            UIImage *image = [self.image mark_colorizedCopyWithColor:self.color
                                                                 blendMode:[self.blendMode intValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        });
    } else if (self.image) {
        self.imageView.image = self.image;
    }
}

@end
