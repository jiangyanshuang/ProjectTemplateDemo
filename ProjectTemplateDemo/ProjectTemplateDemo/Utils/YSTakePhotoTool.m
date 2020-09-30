//
//  YSTakePhotoTool.m
//  ProjectTemplateDemo
//
//  Created by YanShuang Jiang on 2020/8/29.
//  Copyright © 2020 WuHanOnePointOne. All rights reserved.
//

#import "YSTakePhotoTool.h"

#define AppRootView ([[[[[UIApplication sharedApplication]delegate]window]rootViewController]view])
#define AppRootViewController ([[[[UIApplication sharedApplication]delegate]window]rootViewController])

@implementation YSTakePhotoTool

+ (YSTakePhotoTool *)sharedPhoto {
    static YSTakePhotoTool *sharedModel = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedModel = [[self alloc]init];
    });
    return sharedModel;
}

- (void)sharePictureWithView:(UIView *)view pictureWithBlock:(sendPictureBlock)block {
    
    self.pictureBlock = block;
    UIAlertController *sheetViewController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //iPad上需要设置UIAlertController这个弹出窗口的位置信息（当使用UIAlertController的UIAlertControllerStyleActionSheet时在iPad上运行会崩溃）
    //.sourceView 用来指定用来显示popover的view
    //.sourceRect 用来指定popover的箭头指向哪里
    
    if (isPad) {
        if ([YSTools dx_isNullOrNilWithObject:view]) {
            return;
        }
        sheetViewController.popoverPresentationController.sourceView = view.superview;
        sheetViewController.popoverPresentationController.sourceRect = view.frame;
    }
    
    UIImagePickerController *imagePickrerController = [[UIImagePickerController alloc]init];
    imagePickrerController.delegate = self;
    imagePickrerController.allowsEditing = YES;
    imagePickrerController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [sheetViewController addAction:[UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickrerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [AppRootViewController presentViewController:imagePickrerController animated:YES completion:NULL];
    }]];
    [sheetViewController addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickrerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [AppRootViewController presentViewController:imagePickrerController animated:YES completion:NULL];
    }]];
    [sheetViewController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [AppRootViewController presentViewController:sheetViewController animated:YES completion:nil];
}

#pragma mark imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.pictureBlock) {
        self.pictureBlock(image);
    }
}

@end
