//
//  UIView+AutoSizeToDevice.h
//  XibAutoLayoutDemo
//
//  Created by sogou on 16/6/20.
//  Copyright © 2016年 sogou. All rights reserved.
//

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
