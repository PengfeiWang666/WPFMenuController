//
//  UIColor+HexColor.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/25.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)randomColor {
    CGFloat red   = (arc4random() % 256) / 256.0;
    CGFloat green = (arc4random() % 256) / 256.0;
    CGFloat blue  = (arc4random() % 256) / 256.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (instancetype)colorWithHexaString:(NSString *)hexaString {
    
    CGFloat a = [[hexaString substringFromIndex:hexaString.length - 4] floatValue];
    
    hexaString = [hexaString substringToIndex:hexaString.length - 4];
    
    unsigned long hex = strtoul([hexaString UTF8String],0,16);
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 \
                           green:((float)((hex & 0x00FF00) >>  8))/255.0 \
                            blue:((float)((hex & 0x0000FF) >>  0))/255.0 \
                           alpha:a];
}

@end
