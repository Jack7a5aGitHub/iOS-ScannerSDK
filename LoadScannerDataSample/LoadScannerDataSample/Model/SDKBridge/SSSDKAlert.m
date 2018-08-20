//
//  SSSDKAlert.m
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeviceControl.h"
#import "SSSDKScanSetting.h"
#import "SSSDKAlert.h"

typedef void (^scanAlertType)(BUTTON_INDEX buttonIndex);

@interface SSSDKAlert ()

@property (copy, nonatomic) scanAlertType callBackBlock;

- (void)cancelAction;
- (void)defaultAction;
- (void)openAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherBtnTitle:(NSString *)otherBtnTitle processView:(UIActivityIndicatorView *)processView;

@end

@implementation SSSDKAlert

+ (SSSDKAlert *)sharedAlertController {
    static SSSDKAlert *sharedAlertController;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedAlertController = [[self alloc] init];
    });
    return sharedAlertController;
}

- (void)showScanAlert:(SSSDKScanAlertType)type errorCode:(NSInteger)errorCode withCallBackBlock:(void (^)(BUTTON_INDEX buttonIndex))callBackBlock {
    self.callBackBlock = callBackBlock;
    self.scanAlertType = type;
    
    NSString    *alertTitle    = nil;
    NSString    *alertMessage    = nil;
    NSString    *cancelBtnTitle    = nil;
    NSString    *defaultBtnTitle    = nil;
    SSSDKProcessViewType    processType    = SSSDKProcessViewTypeNoIndicatorView;
    UIActivityIndicatorView    *processView    = nil;
    
    switch (type) {
        case SSSDKScanAlertTypeScanning:
            alertTitle = @"Scanning";
            alertMessage = @"Press [Stop] To Stop";
            cancelBtnTitle = @"Stop";
            processType = SSSDKProcessViewTypeIndicatorViewStyleGray;
            break;
        case SSSDKScanAlertTypeContinueScan:
            alertTitle = @"Continue Scan?";
            alertMessage = @"Press [Finish] To Stop, [Continue] to resume";
            cancelBtnTitle = @"Finish";
            defaultBtnTitle = @"Continue";
            break;
        case SSSDKScanAlertTypeError:
            alertTitle = @"Error Occured";
            if (errorCode == ERR_PAPER_JAM) {
                alertMessage = [NSString stringWithFormat:@"Error Code = %ld.\nPress [Stop] to stop, [Continue] to coninue", (long)errorCode];
                defaultBtnTitle = @"Continue";
            } else {
                alertMessage = [NSString stringWithFormat:@"Error Code = %ld.\nPress [Stop] to stop", (long)errorCode];
            }
            cancelBtnTitle = @"Stop";
            break;
        case SSSDKScanAlertTypeMultiFeed:
            alertTitle = @"Multi Feed Occured";
            alertMessage = @"Do you want to delete last file?";
            cancelBtnTitle = @"Don't";
            defaultBtnTitle = @"Delete";
            break;
        case SSSDKScanAlertTypeDeleteFile:
            alertTitle = @"Delete File?";
            alertMessage = @"Do you want to delete this file?";
            cancelBtnTitle = @"Don't";
            defaultBtnTitle = @"Delete";
            break;
        case SSSDKScanAlertTypeConnectError:
            alertTitle = @"Connect failed";
            alertMessage = [NSString stringWithFormat:@"Cannot connect this Scanner. Error Code = %ld.\nPress [Close] to close the dialog.", (long)errorCode];
            defaultBtnTitle = @"Close";
            break;
        case SSSDKScanAlertTypeWrongPassword:
            alertTitle = @"Wrong password";
            alertMessage = @"Please enter the correct password.";
            cancelBtnTitle = @"Skip";
            defaultBtnTitle = @"Connect";
            break;
        default:
            break;
    }
    
    switch (processType) {
        case SSSDKProcessViewTypeIndicatorViewStyleGray:
            processView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            break;
        case SSSDKProcessViewTypeIndicatorViewStyleWhite:
            processView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            break;
        case SSSDKProcessViewTypeIndicatorViewStyleWhiteLarge:
            processView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            break;
        default:
            break;
    }
    [processView startAnimating];
    [self openAlertView:alertTitle message:alertMessage cancelButtonTitle:cancelBtnTitle otherBtnTitle:defaultBtnTitle processView:processView];
}

- (void)openAlertView:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherBtnTitle:(NSString *)otherBtnTitle processView:(UIActivityIndicatorView *)processView {
    UIAlertView    *alertView    = [[UIAlertView alloc] init];
    alertView.title = title;
    alertView.message = message;
    alertView.delegate = self;
    if (cancelButtonTitle != nil) {
        [alertView addButtonWithTitle:cancelButtonTitle];
    }
    if (otherBtnTitle != nil) {
        [alertView addButtonWithTitle:otherBtnTitle];
    }
    if (self.scanAlertType == SSSDKScanAlertTypeWrongPassword) {
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    }
    [alertView show];
    self.alertController = alertView;
}

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case BUTTON_INDEX_CANCEL:
            [self cancelAction];
            break;
        case BUTTON_INDEX_DEFAULT:
            [self defaultAction];
            break;
        default:
            break;
    }
    self.scanAlertType = SSSDKScanAlertTypeOthers;
}

- (void)cancelAction {
    if (self.callBackBlock == nil) {
        
        //AppDelegate * appDelegate    = (AppDelegate *)[UIApplication sharedApplication].delegate;
        switch (self.scanAlertType) {
            case SSSDKScanAlertTypeContinueScan:
            case SSSDKScanAlertTypeScanPaused:
              //  [appDelegate scanFinish];
                break;
            default:
              //  [appDelegate.deviceCtrl.device cancelScan];
                break;
        }
    }
    else {
        self.callBackBlock(BUTTON_INDEX_CANCEL);
    }
}

- (void)defaultAction {
    if (self.callBackBlock == nil) {
       // AppDelegate    *appDelegate    = (AppDelegate *)[UIApplication sharedApplication].delegate;
        switch (self.scanAlertType) {
            case SSSDKScanAlertTypeContinueScan:
            case SSSDKScanAlertTypeScanPaused:
            case SSSDKScanAlertTypeError:
                //in this demo application
                //the continue scan button will be only displayed when jam occurred
               // [appDelegate continueScan:[[SSSDKScanSettings sharedScanSettings] settingsDictionary]];
                break;
            default:
               // [appDelegate scanFinish];
                break;
        }
    }
    else {
        self.callBackBlock(BUTTON_INDEX_DEFAULT);
    }
}

- (void)dismissAlert:(NSInteger)buttonIndex {
    [self.alertController dismissWithClickedButtonIndex:buttonIndex animated:YES];
    self.scanAlertType = SSSDKScanAlertTypeOthers;
}

@end
