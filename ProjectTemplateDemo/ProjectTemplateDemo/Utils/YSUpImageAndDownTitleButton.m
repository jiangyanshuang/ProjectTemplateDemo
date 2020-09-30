//
//  YSUpImageAndDownTitleButton.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSUpImageAndDownTitleButton.h"

@implementation YSUpImageAndDownTitleButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //image
    CGPoint center;
    
    center.x = self.frame.size.width/2;
    center.y =  (self.frame.size.height - self.imageView.frame.size.height)/2;
    
    self.imageView.center = center;
    
    //text
    CGRect newFrame = [self titleLabel].frame;
    
    newFrame.origin.x = 0;
    newFrame.origin.y = self.frame.size.height/2 + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

@end
