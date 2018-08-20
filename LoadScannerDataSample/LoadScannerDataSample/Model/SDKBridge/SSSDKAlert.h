//
//  SSSDKAlert.h
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _BUTTON_INDEX {
    BUTTON_INDEX_CANCEL = 0,
    BUTTON_INDEX_DEFAULT,
}BUTTON_INDEX;

typedef enum _SSSDKProcessViewType {
    SSSDKProcessViewTypeNoIndicatorView = 0,
    SSSDKProcessViewTypeIndicatorViewStyleGray,
    SSSDKProcessViewTypeIndicatorViewStyleWhite,
    SSSDKProcessViewTypeIndicatorViewStyleWhiteLarge,
}SSSDKProcessViewType;

typedef enum SSSDKScanAlertType {
    SSSDKScanAlertTypeScanning = 0,
    SSSDKScanAlertTypeContinueScan,
    SSSDKScanAlertTypeScanPaused,
    SSSDKScanAlertTypeError,
    SSSDKScanAlertTypeMultiFeed,
    SSSDKScanAlertTypeDeleteFile,
    SSSDKScanAlertTypeConnectError,
    SSSDKScanAlertTypeWrongPassword,
    SSSDKScanAlertTypeOthers,
}SSSDKScanAlertType;

@interface SSSDKAlert : NSObject <UIAlertViewDelegate>

@property (retain, nonatomic) id alertController;
@property (assign, nonatomic) SSSDKScanAlertType scanAlertType;

+ (SSSDKAlert *)sharedAlertController;
- (void)dismissAlert:(NSInteger)buttonIndex;
- (void)showScanAlert:(SSSDKScanAlertType)type errorCode:(NSInteger)errorCode withCallBackBlock:(void (^)(BUTTON_INDEX buttonIndex))callBackBlock;

@end
