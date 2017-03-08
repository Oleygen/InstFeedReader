//
//  UIViewController+Alert.m
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

-(void)showErrorPopup:(NSString *)alertMessage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
