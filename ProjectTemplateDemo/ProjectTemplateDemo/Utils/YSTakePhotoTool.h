//
//  YSTakePhotoTool.h
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import <Foundation/Foundation.h>
//使用block 返回值
typedef void(^sendPictureBlock)(UIImage *image);

NS_ASSUME_NONNULL_BEGIN

@interface YSTakePhotoTool : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy)sendPictureBlock pictureBlock;

+ (YSTakePhotoTool *)sharedPhoto;
- (void)sharePictureWithView:(UIView *)view pictureWithBlock:(sendPictureBlock)block;

@end

NS_ASSUME_NONNULL_END
