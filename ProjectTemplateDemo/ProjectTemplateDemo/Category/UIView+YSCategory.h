//
//  UIView+YSCategory.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YSCategory)

#pragma mark - 位置大小

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize  size;

@property (assign, nonatomic) CGPoint origin;

#pragma mark - 设置渐变色

@property(nullable, copy) NSArray *az_colors;

@property(nullable, copy) NSArray<NSNumber *> *az_locations;

@property CGPoint az_startPoint;

@property CGPoint az_endPoint;

/**
 
 [UIView az_setGradientBackgroundWithColors:@[YSColor(255, 125, 0, 1),YSColor(255, 72, 0, 1)] locations:@[@(0.0),@(1.0)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];

 */
+ (UIView *_Nullable)az_gradientViewWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (void)az_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


@end

NS_ASSUME_NONNULL_END
