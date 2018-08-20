/************************************************************************
 *	File name		:PFUDevice.h
 *	Program name	:SsSvcMobileWIFIFrmwk
 *	ALL RIGHTS RESERVED,COPYRIGHT(C) PFU LIMITED 2014
 ************************************************************************/
#import <Foundation/Foundation.h>
#import "PFUDeviceType.h"


/*!
 @discussion    Connection status of scanner
 */
typedef enum {
    /*!
     @brief     Connecting the scanner.
     */
    PFUDeviceConnectionStatusConnecting,
    /*!
     @brief     The scanner has been connected.
     */
    PFUDeviceConnectionStatusConnected,
    /*!
     @brief     Disconnecting the scanner.
     */
    PFUDeviceConnectionStatusDisconnecting,
    /*!
     @brief     The scanner has been disconnected.
     */
    PFUDeviceConnectionStatusDisconnected
} PFUDeviceConnectionStatus;

/*!@mainpage
 Using ScanSnap SDK for Mobile allows you to start scanning documents in ScanSnap directly from your mobile application via wireless LAN (*1). You can therefore easily acquire the scanned image (such as a PDF file or a JPEG file).
 
 (*1):Your mobile device and the ScanSnap must be connected to the same wireless LAN network in advance.\n\n
 ::PFUDevice\n
 ::PFUDeviceManager\n
 ::PFUDeviceType\n
 ::PFUSSDevice\n
 ::PFUSSDeviceManager\n
 */
/*
 The ::PFUDevice class declares the programmatic interface for an object that
 Scanner device control, ::PFUDevice declares methods for connecting and disconnecting.
 It also declares properties for deviceType,deviceName,macAddress,connectionStatus.
 The subclass of ::PFUDevice is ::PFUSSDevice.
  */
@interface PFUDevice : NSObject <NSCoding>

/*! 
 @brief     Type of scanner(read-only), see ::PFUDeviceType for more.
 */
@property(nonatomic, readonly) PFUDeviceType deviceType;
/*! 
 @brief     Name of scanner (read-only)
  */
@property(nonatomic, readonly) NSString *deviceName;
/*! 
 @brief     Mac address of scanner (read-only)
  */
@property(nonatomic, readonly) NSString *macAddress;
/*!
 @brief     Connection status of scanner (read-only)
 */
@property(nonatomic, readonly) PFUDeviceConnectionStatus connectionStatus;

/*!
 @brief     Connect to scanner.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_HAS_OTHER_DEVICE_CONNECTED, ::ERR_INVALID_PASSWORD,the localized description of the error will tell you what happend.
 @details   Posted ::PFUDeviceDidConnectNotification when the scanner is connected. Also, posted ::PFUDeviceFailToConnectNotification when scanner connection failed.
 @note      Make sure scanner status is 'disconnected'. You can confirm the case of the failure from ::PFUDeviceFailToConnectNotification.
 */
- (NSError *)connect;

/*! 
 @brief     Disconnect the scanner.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_ALREADY_IN_SCAN_SESSION, ::ERR_DEVICE_NOT_CONNECTED,the localized description of the error will tell you what happend.
 @details   Posted ::PFUDeviceDidDisconnectNotification when the scanner is disconnected.
 @note      Make sure scanner status is 'connected' and the scanner is in scan session.
  */
- (NSError *)disconnect;

@end

/*! 
 @brief     Posted when the scanner is connected.
  */
PFU_EXTERN NSString * const PFUDeviceDidConnectNotification;

/*! 
 @brief     Posted when the scanner is disconnected.
  */
PFU_EXTERN NSString * const PFUDeviceDidDisconnectNotification;

/*! 
 @brief     Posted when connection failed.
 @details   Use the keys described in 'SDK Error Key' to get object from the userInfo dictionary.
 You can get the NSError object with one of the codes below,The NSError object containing the localized explanation of the reason and recovery suggestion.
 ::ERR_DEVICE_USED, ::ERR_WRONG_PASSWORD, ::ERR_BAD_NETWORK_CONNECTION, ::ERR_UNEXPECTED_SW_ERROR
 
 You need to set the password in password when the error code is ::ERR_WRONG_PASSWORD.
  */
PFU_EXTERN NSString * const PFUDeviceFailToConnectNotification;
