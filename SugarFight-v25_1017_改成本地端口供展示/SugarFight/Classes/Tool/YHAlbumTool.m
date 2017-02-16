//
//  YHAlbumTool.m
//  SugarFight
//
//  Created by Cui yuhe on 16/5/24.
//  Copyright © 2016年 Cui yuhe. All rights reserved.
//

#import "YHAlbumTool.h"

@interface YHAlbumTool()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 从相册选中的image */
@end

@implementation YHAlbumTool
SingleM(AlbumTool)

/**
 *  @param vc modal出UIImagePickerController的控制器
 */
- (void)openAlbumWithVc:(UIViewController *)vc{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [MBProgressHUD showError:@"打开相册失败,请在设置中打开相册权限."];
        return;
    }
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [vc presentViewController:ipc animated:YES completion:nil];
    
}

#pragma mark ------------------------------------------
#pragma mark UIImageViewController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if ([self.delegate respondsToSelector:@selector(albumToolDidSelectImage:albumTool:)]) {
        [self.delegate albumToolDidSelectImage:image albumTool:self];
    }
}

@end
