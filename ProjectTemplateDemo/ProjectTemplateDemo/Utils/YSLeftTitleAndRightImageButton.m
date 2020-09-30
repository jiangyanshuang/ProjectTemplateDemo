//
//  YSLeftTitleAndRightImageButton.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSLeftTitleAndRightImageButton.h"

@implementation YSLeftTitleAndRightImageButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect labFrame = [self titleLabel].frame;
    CGRect imgFrame = [self imageView].frame;
    
    float x = (self.frame.size.width - labFrame.size.width - imgFrame.size.width - 5)/2.0;

    CGRect newLabFrame = CGRectMake(x, labFrame.origin.y, labFrame.size.width, labFrame.size.height);
    CGRect newImgFrame = CGRectMake(x + labFrame.size.width + 5, imgFrame.origin.y, imgFrame.size.width, imgFrame.size.height);
    
    self.titleLabel.frame = newLabFrame;
    self.imageView.frame = newImgFrame;
}

@end
