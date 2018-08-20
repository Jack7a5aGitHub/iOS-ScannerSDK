//
//  SSSDKScanSetting.m
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import "SSSDKScanSetting.h"
#import "DeviceControl.h"
#define SSDeviceLastConnectedDeviceName @"SSDeviceLastConnectedDeviceName"

@implementation SSSDKScanSettings

+ (SSSDKScanSettings *)sharedScanSettings {
    static SSSDKScanSettings *sharedScanSettings;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedScanSettings = [[self alloc] init];
        sharedScanSettings.userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return sharedScanSettings;
}

- (void)setIntegerValue:(NSInteger)value withKey:(NSString *)key {
    [self.userDefaults setObject:[NSNumber numberWithInteger:value] forKey:key];
    [self.userDefaults synchronize];
}

//file format
- (NSInteger)fileFormat {
    NSInteger    returnValue    = PFUFileFormatOptionPdf;
    NSNumber    *obj        = (NSNumber *)[self.userDefaults objectForKey:SSDeviceScanSettingFileFormatKey];
    if (obj != nil) {
        returnValue = [obj integerValue];
    }
    return returnValue;
}

- (void)setFileFormat:(NSInteger)fileFormat {
    [self.userDefaults setObject:[NSNumber numberWithInteger:fileFormat] forKey:SSDeviceScanSettingFileFormatKey];
    [self.userDefaults synchronize];
}

- (BOOL)needResetSettings {
    BOOL        needReset    = NO;
    NSNumber    *obj        = (NSNumber *)[self.userDefaults objectForKey:SSDeviceScanSettingFileFormatKey];
    
    if (obj == nil) {
        needReset = YES;
    } else {
        needReset = NO;
    }
    
    return needReset;
}

- (void)resetSettings {
    self.fileFormat = PFUFileFormatOptionPdf;
}

- (NSDictionary *)settingsDictionary {
    NSDictionary    *plistSettings    = [self.userDefaults dictionaryWithValuesForKeys:@[SSDeviceScanSettingFileFormatKey]];
    NSMutableDictionary    *dictSettings    = [NSMutableDictionary dictionaryWithDictionary:plistSettings];
    [dictSettings setObject:[self saveFolderFullPath] forKey:SSDeviceScanSettingSaveFolderKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUPaperSizeOptionAuto] forKey:SSDeviceScanSettingPaperSizeKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUColorModeOptionAuto] forKey:SSDeviceScanSettingColorModeKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUBrightnessOptionLevel6] forKey:SSDeviceScanSettingBrightnessKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUImageQualityOptionAuto] forKey:SSDeviceScanSettingImageQualityKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUCompressionOptionLevel3] forKey:SSDeviceScanSettingCompressionKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUScanningSideOptionBothSurfaces] forKey:SSDeviceScanSettingScanningSideKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUBlankRemoveOptionON] forKey:SSDeviceScanSettingBlankRemovalKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUBleedThroughOptionOFF] forKey:SSDeviceScanSettingBleedThroughKey];
    [dictSettings setObject:[NSNumber numberWithInt:PFUMultiFeedOptionON] forKey:SSDeviceScanSettingMultiFeedKey];
    
    return dictSettings;
}

- (NSString *)saveFolderFullPath {
    NSArray        *folders    = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString    *folder        = (NSString *)folders[0];
    NSString    *saveFolder    = [folder stringByAppendingPathComponent:DEFAULT_SAVE_FOLDER];
    
    NSFileManager    *fileManager    = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:saveFolder] == NO) {
        [fileManager createDirectoryAtPath:saveFolder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return saveFolder;
}

- (void)setLastConnectedDevice:(PFUSSDevice *)lastConnectedDevice
{
    if (lastConnectedDevice) {
        
        NSData  *data = [NSKeyedArchiver archivedDataWithRootObject:lastConnectedDevice];
        [self.userDefaults setObject:data forKey:SSDeviceLastConnectedDeviceName];
        [self.userDefaults synchronize];
    } else {
        [self.userDefaults removeObjectForKey:SSDeviceLastConnectedDeviceName];
        [self.userDefaults synchronize];
        return;
    }
}


- (PFUSSDevice *)lastConnectedDevice
{
    PFUSSDevice *device = nil;
    NSData *data = [self.userDefaults dataForKey:SSDeviceLastConnectedDeviceName];
    if (data) {
        device = (PFUSSDevice*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return device;
}

@end
