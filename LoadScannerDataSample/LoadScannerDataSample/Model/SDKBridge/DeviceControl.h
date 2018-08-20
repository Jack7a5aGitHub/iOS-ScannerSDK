//
//  DeviceControl.h
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/07.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SsSvcMobileWIFIFrmwk/PFUDevice.h>
#import <SsSvcMobileWIFIFrmwk/PFUDeviceManager.h>
#import <SsSvcMobileWIFIFrmwk/PFUDeviceType.h>
#import <SsSvcMobileWIFIFrmwk/PFUSSDevice.h>
#import <SsSvcMobileWIFIFrmwk/PFUSSDeviceManager.h>

@class DeviceControl;

@protocol DeviceCtrlDelegate <NSObject>

- (void)device:(PFUSSDevice *)deviceInfo connectSuccessfully:(NSError *)error;
- (void)connectDeviceAndStartScan;
- (void)connectDeviceWithIndexPath:(NSIndexPath *)indexPath;
- (void)doDisconnection:(NSIndexPath *)indexPath;
- (void)continueScan:(NSDictionary *)scanSetting;
- (void)showScanAlert;
- (void)scanFinish;
- (void)showScanErrorOccurWithErrorCode:(NSInteger)errorCode;
- (void)showMultiFeedOccur;
- (void)deliverScanFile:(id)pageInfo;
- (void)didDisconnectToTheDevice;

@end

@interface DeviceControl : NSObject
@property (retain, readwrite) PFUSSDevice *device;
@property (retain, readwrite) id<DeviceCtrlDelegate> delegate;

- (void)addNotification;

#pragma mark ------- Connect Flow -------
//
//Step 1：Search enabled ScanSnap devices
//
-(NSError *)searchDevices:(void (^)(NSArray * deviceList))block;
//
//Step 2：Receive the notification when device list changed
//PFUDeviceManagerListOfDevicesDidChangeNotification
//
- (void)listOfScannersDidChange:(NSNotification *)notification;


//
//Step 3：connect device
//PFUDeviceDidConnectNotification
- (void)connectDeviceWithIndex:(NSInteger)selectedDeviceIndex;
- (NSError *)connectScanner;
- (NSError *)connectWithPassword:(NSString *)password;

- (void)deviceDidConnect:(NSNotification *)notification;

//PFUDeviceDidFailToConnectNotification
- (void)deviceDidFailToConnect:(NSNotification *)notification;

#pragma mark ------- Scan Flow Pattern #1 Press [scan] button on the ScanSnap-------
//
//Step 1:Receive the notification when [scan] button on the ScanSnap pressed
//SSDeviceDidPressScanButtonNotification
//

- (void)deviceDidPressScanButton:(NSNotification *)notification;

//
//Step 2:Receive the notification when there is any pages scanned.
//       The file is always JPEG.(even save fileformat is PDF or JPEG)
//SSDeviceDidScanPageNotification
//
- (void)deviceDidScannedPage:(NSNotification *)notification;
//
//Step 3:Receive the notification when PDF is created.
//       This notification will received only fileformat is PDF, and called endScanSesstion
//SSDeviceDidScanPageNotification
//
- (void)pdfFilePathNotificationReceived:(NSNotification*)notification;

//
//Step 3:Scan finished
//SSDeviceDidFinishScanNotification
//
- (void)deviceDidFinishScan:(NSNotification *)notification;

#pragma mark ------- Scan Flow Pattern #2 Scan settings and error-------
//
//1):Pass the settings to Framework
//
- (void)scanAction:(NSDictionary *)scanSettingDic;
//
//2):Do someting when scan finished
//
- (void)finishScanAction;
//
//3):For continue scan, the setting also can be set to framework
//
- (void)continueScanAction:(NSDictionary *)scanSettingDic;
//
//3):Receive the notification when Error occured
//SSDeviceDidErrorDuringScanNotification
//
- (void)deviceDidErrorDuringScan:(NSNotification *)notification;

#pragma mark ------- Scan Flow Pattern #3 Multifeed-------

//
//Receive the notification when Multifeed occured
//SSDeviceDidPauseForMultifeedNotification
//
- (void)deviceDidPauseForMultifeed:(NSNotification *)notification;

#pragma mark ------- Disconnect-------

//
//Step 1:Disconnet scanner
//
- (NSError *)disconnectScanner;

//
//Step 2:Receive the notification when device disconnected
//PFUDeviceDidDisconnectNotification
- (void)deviceDidDisconnect:(NSNotification *)notification;

@end
