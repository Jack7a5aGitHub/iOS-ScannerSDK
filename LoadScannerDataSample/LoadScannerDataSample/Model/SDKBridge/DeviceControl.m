//
//  DeviceControl.m
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/07.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import "DeviceControl.h"
#import <UIKit/UIKit.h>
#import "SSSDKScanSetting.h"
#import "SSSDKAlert.h"

typedef void (^getDeviceList)(NSArray * deviceList);

@interface DeviceControl()

@property (copy, nonatomic) getDeviceList getDeviceListBlock;

@end

@implementation DeviceControl

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addNotification];
    }
    return self;
}

- (void)addNotification
{
    NSNotificationCenter    *notificationCenter    = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(listOfScannersDidChange:)
                               name:PFUDeviceManagerListOfDevicesDidChangeNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidConnect:)
                               name:PFUDeviceDidConnectNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidFailToConnect:)
                               name:PFUDeviceFailToConnectNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidPressScanButton:)
                               name:SSDeviceDidPressScanButtonNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidScannedPage:)
                               name:SSDeviceDidScanPageNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidFinishScan:)
                               name:SSDeviceDidFinishScanNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidErrorDuringScan:)
                               name:SSDeviceDidErrorDuringScanNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidPauseForMultifeed:)
                               name:SSDeviceDidPauseForMultifeedNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(deviceDidDisconnect:)
                               name:PFUDeviceDidDisconnectNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(pdfFilePathNotificationReceived:)
                               name:SSDevicePDFFilePathNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(connectedDeviceDidChange:)
                               name:PFUDeviceManagerConnectedDeviceDidChangeNotification
                             object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ------- Search Flow -------

//Step 1:Search for scanner.
-(NSError *)searchDevices:(void (^)(NSArray * deviceList))block {
    PFUDeviceManager * manager = [PFUDeviceManager sharedDeviceManagerWithType:PFUDeviceTypeScanSnap];
    [manager setLogLevel:LogModeLevel0];
    self.getDeviceListBlock = block;
    return [manager searchForDevices:PFUScanSnapAll];
}

//Step 2:Get infomation of searched scanner.
- (void)listOfScannersDidChange:(NSNotification *)notification
{
    self.getDeviceListBlock([PFUDeviceManager sharedDeviceManagerWithType:PFUDeviceTypeScanSnap].devices);
}

#pragma mark ------- Connect -------
//Step 1:Get infomation of scanner to connect.
- (void)connectDeviceWithIndex:(NSInteger)selectedDeviceIndex
{
    self.device = [PFUDeviceManager sharedDeviceManagerWithType:PFUDeviceTypeScanSnap].devices[selectedDeviceIndex];
    NSLog(@"12345%u",self.device.connectionStatus);
    NSLog(@"12345%@",self.device.ipAddress);
}

//Step 2:Connect to scanner.
- (NSError *)connectScanner
{
    NSError * error = [self.device connect];
    
    return error;
}

- (NSError *)connectWithPassword:(NSString *)password
{
    NSError *error = nil;
    self.device.password = password;
    error = [self.device connect];
    return error;
}

//Step 3:Check that scanner has been connected.
- (void)deviceDidConnect:(NSNotification *)notification
{
    [self.delegate device:self.device connectSuccessfully:nil];
}

//Confirm the case of the failure when connection failed.
- (void)deviceDidFailToConnect:(NSNotification *)notification
{
    NSError * error = [notification userInfo][SSDeviceErrorKey];
    [self.delegate device:self.device connectSuccessfully:error];
}

- (void)connectedDeviceDidChange:(NSNotification*)notification {
}

#pragma mark ------- Scan -------
//Step 1:Start scan.
- (void)scanAction:(NSDictionary *)scanSettingDic {
    NSError * error = nil;
    
    [self.device beginScanSession];
    
    error = [self.device scanDocuments:scanSettingDic];
    if (error) {
        [self.delegate showScanErrorOccurWithErrorCode:[error code]];
    }
    else {
        [self.delegate showScanAlert];
    }
}

- (void)deviceDidPressScanButton:(NSNotification *)notification
{
    [self scanAction:[[SSSDKScanSettings sharedScanSettings] settingsDictionary]];
}


//Step 2:Get infomation of scaned page.
- (void)deviceDidScannedPage:(NSNotification *)notification
{
    id  strFrontPage = [[notification userInfo] objectForKey:SSDevicePageInfoFilePathFrontKey];
    id  strBackPage = [[notification userInfo] objectForKey:SSDevicePageInfoFilePathBackKey];
    
    if ([SSSDKScanSettings sharedScanSettings].fileFormat == PFUFileFormatOptionJpeg)
    {
        if ([strFrontPage isKindOfClass:[NSString class]])
        {
            NSLog(@"FrontPage%@", strFrontPage);
            [self.delegate deliverScanFile:strFrontPage];
        }
        if ([strBackPage isKindOfClass:[NSString class]])
        {
            NSLog(@"BackPage%@", strBackPage);
            [self.delegate deliverScanFile:strBackPage];
        }
    }
}

//Step 3:Check that scanner finishes scanning.
- (void)deviceDidFinishScan:(NSNotification *)notification
{
    [self.delegate scanFinish];
}

//Step 4:End scan session and disconnect to scanner.
-(void)finishScanAction
{
    [self.device endScanSession];
    [self disconnectScanner];
}

//Step 5:Get path of created PDF.
- (void)pdfFilePathNotificationReceived:(NSNotification*)notification
{
    id  strPDFPage = [[notification userInfo] objectForKey:SSDevicePDFFilePathKey];
    if ([strPDFPage isKindOfClass:[NSString class]])
    {
        NSLog(@"PDFPage%@", strPDFPage);
        [self.delegate deliverScanFile:strPDFPage];
    }
}

#pragma mark ------- Scanning Err -------

//Check whether a page delete or not.
- (void)deviceDidPauseForMultifeed:(NSNotification *)notification
{
    [self.delegate showMultiFeedOccur];
}

//Confirm the case of the failure when scanning failed.
- (void)deviceDidErrorDuringScan:(NSNotification *)notification
{
    NSDictionary    *userInfo        = [notification userInfo];
    NSError            *ErrorCode        = [userInfo objectForKey:@"SSDeviceError"];
    [self.delegate showScanErrorOccurWithErrorCode:[ErrorCode code]];
}

- (void)continueScanAction:(NSDictionary *)scanSettingDic {
    NSError * error = nil;
    
    error = [self.device scanDocuments:scanSettingDic];
    NSLog(@"continue Scan %@", error);
    if (error) {
        [self.delegate showScanErrorOccurWithErrorCode:[error code]];
    }
    else {
        [self.delegate showScanAlert];
    }
}



#pragma mark ------- Disconnect -------
//Step 1:Disconnect to scanner.
- (NSError *)disconnectScanner
{
    PFUDeviceManager * manager = [PFUDeviceManager sharedDeviceManagerWithType:PFUDeviceTypeScanSnap];
    NSLog(@"start disconnect, %@", manager.connectedDevice);
    NSError    *error    = nil;
    if (manager.connectedDevice != nil) {
        error = [self.device disconnect];
        NSLog(@"DisconnectedToTheDevice");
        NSLog(@"%@", error);
    }
    return error;
}

//Step 2:Check that scanner has been disconnected.
- (void)deviceDidDisconnect:(NSNotification *)notification
{
    [self.delegate didDisconnectToTheDevice];
}

@end
