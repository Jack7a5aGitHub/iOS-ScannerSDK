//
//  SSSDKScanSetting.h
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SsSvcMobileWIFIFrmwk/PFUSSDevice.h"

#define DEFAULT_SAVE_FOLDER    @"ScanSnap"

@interface SSSDKScanSettings : NSObject

@property (assign, nonatomic) NSInteger  fileFormat;
@property (retain, nonatomic) PFUSSDevice *lastConnectedDevice;
@property (retain, nonatomic) NSUserDefaults  *userDefaults;

+ (SSSDKScanSettings *)sharedScanSettings;
- (BOOL)needResetSettings;
- (void)resetSettings;
- (NSDictionary *)settingsDictionary;
- (NSString *)saveFolderFullPath;

@end
