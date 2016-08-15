//
//  UIView+AutoSizeToDevice.h


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZDGAutoSize : NSObject
+(CGFloat) fitHeightToDevices:(CGFloat) height;
+(CGFloat) fitSizeToDevices:(CGFloat) length;
+(CGFloat) fitSizeToDevices:(CGFloat) length withRatio:(CGFloat)ratio;
+(CGFloat)fitSizeToAboveDevice6:(CGFloat)length;
@end

@interface UIView(AutoSizeToDevice)

@property(nonatomic, assign)BOOL dg_viewAutoSizeToDevice;

@end
