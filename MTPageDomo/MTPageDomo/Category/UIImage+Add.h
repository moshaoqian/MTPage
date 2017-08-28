

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImage:(NSString *)imgName;

#pragma mark 可以自由拉伸的图片 可传拉伸位置
+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos;
//裁切图片为正方形
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


+ (UIImage *)handleImage:(UIImage *)originalImage withSize:(CGSize)size;

@end
