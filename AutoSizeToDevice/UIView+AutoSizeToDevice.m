//
//  UIView+AutoSizeToDevice.m
//  XibAutoLayoutDemo
//
//  Created by sogou on 16/6/20.
//  Copyright © 2016年 sogou. All rights reserved.
//

#import "UIView+AutoSizeToDevice.h"
#import <objc/runtime.h>

@implementation ZDGAutoSize
+(BOOL)isDevicePlus
{
    NSInteger width = [[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
    return width > 400;
    //    return [[UIScreen mainScreen] bounds].size.width>400;
}
+(BOOL)isDevice6
{
    NSInteger width = [[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
    return width == 375;
    //    return [[UIScreen mainScreen] bounds].size.width == 375;
}
+(BOOL)isDeviceAboveIphone5
{
    NSInteger width = [[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
    return width > 320;
    //    return [[UIScreen mainScreen] bounds].size.width > 320;
}
+(BOOL)isDevice4
{
    NSInteger width = [[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height;
    return width == 480;
    //    return [[UIScreen mainScreen] bounds].size.height == 480;
}

+(CGFloat) fitHeightToDevices:(CGFloat) height
{
    CGFloat ratio = [UIScreen mainScreen].bounds.size.height/667.f;
    return height*ratio;
}

+(CGFloat)fitSizeToAboveDevice6:(CGFloat)length
{
    CGFloat fitLength = length;
    if ([self isDevicePlus]) {
        fitLength = length * 1.104;
    }
    return fitLength;
}

+(CGFloat) fitSizeToDevices:(CGFloat) length
{
    //iphone6比iPhone5系列扩大了1.175倍。
    return [self fitSizeToDevices:length withRatio:1.175f];
}

+(CGFloat) fitSizeToDevices:(CGFloat) length withRatio:(CGFloat)ratio
{
    CGFloat fitLength = length;
    if (![self isDeviceAboveIphone5]) {
        fitLength = length / ratio;
    }else if([self isDevicePlus]){
        fitLength = length * 1.104;
    }
    return fitLength;
}

@end


@implementation UIView(AutoSizeToDevice)

- (BOOL)dg_viewAutoSizeToDevice
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDg_viewAutoSizeToDevice:(BOOL)dg_viewAutoSizeToDevice
{
    objc_setAssociatedObject(self, @selector(dg_viewAutoSizeToDevice), @(dg_viewAutoSizeToDevice), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self layoutSubviews];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(dg_layoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)dg_layoutSubviews
{
    // Forward to primary implementation.
    [self dg_layoutSubviews];
    
    if (self.dg_viewAutoSizeToDevice) {
        [self autoSizeToDeviceFromRootView:self];
        self.dg_viewAutoSizeToDevice = NO;
    }
}

- (void)autoSizeToDeviceFromRootView:(UIView *)rootView
{
    if (!rootView) {
        return ;
    }
    
    if ([rootView isKindOfClass:UILabel.class]) {
        ((UILabel *)rootView).font = [UIFont systemFontOfSize:[ZDGAutoSize fitSizeToDevices:((UILabel *)rootView).font.pointSize]];
    }
    if ([rootView isKindOfClass:UIButton.class]) {
        CGFloat fontSize = ((UIButton *)rootView).titleLabel.font.pointSize;
        ((UIButton *)rootView).titleLabel.font = [UIFont systemFontOfSize:[ZDGAutoSize fitSizeToDevices:fontSize]];
    }
    
    
    for (int j = 0; j < rootView.constraints.count; ++ j) {
        NSLayoutConstraint *con = rootView.constraints[j];
        con.constant = [ZDGAutoSize fitSizeToDevices:con.constant];
    }
    for (int i = 0; i < rootView.subviews.count; ++ i) {
        UIView *subView = [rootView.subviews objectAtIndex:i];
        [self autoSizeToDeviceFromRootView:subView];
    }
}

@end
