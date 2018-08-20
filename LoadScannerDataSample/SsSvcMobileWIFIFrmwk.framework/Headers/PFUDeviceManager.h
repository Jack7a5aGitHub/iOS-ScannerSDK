/************************************************************************
 *	File name		:PFUDeviceManager.h
 *	Program name	:SsSvcMobileWIFIFrmwk
 *	ALL RIGHTS RESERVED,COPYRIGHT(C) PFU LIMITED 2014
 ************************************************************************/
#import <Foundation/Foundation.h>
#import "PFUDeviceType.h"

/*!
 @discussion    Options for ProductID of scanner
 */
typedef enum
{
    /*!
     @brief     Only iX100
     */
    PFUScanSnapIX100                 = 1UL << 0,
    /*!
     @brief     Only iX500
     */
    PFUScanSnapIX500                 = 1UL << 1,
    /*!
     @brief     All Scanner
     */
    PFUScanSnapAll                   = 0xFFFF
}ScanSnapProductID;

/*!
 @discussion    Options for log level of SDK
 */
typedef enum{
    /*!
     @brief     Log OFF (default)
     */
    LogModeLevel0,
    /*!
     @brief     Log ON (Error)
     */
    LogModeLevel1,
    /*!
     @brief     Log ON (Info)
     */
    LogModeLevel2,
    /*!
     @brief     Log ON (Finest)
     */
    LogModeLevel3,
}LogModeLevel;

@class PFUDevice;

/*!
  The PFUDeviceManager object lets you search the scanner devices with productID or ipAddress.
  The subclass of ::PFUDeviceManager is ::PFUSSDeviceManager.
 */
@interface PFUDeviceManager : NSObject

/*!
 @brief     An array of ::PFUSSDevice objects, each of which has scanner infomation.(read-only)
 @details   This property returns an empty array if the scanner is not detected.
  */
@property(atomic, readonly) NSArray *devices;

/*! 
 @brief     Object of connected scanner (read-only)
 @details   This property returns nil if scanner status is 'disconnected'.
  */
@property(nonatomic, readonly) PFUDevice *connectedDevice;

/*! 
 @brief     Specify type of scanner, and Object is created.
 @param     deviceType   see ::PFUDeviceType.
 @return    Object of ::PFUDeviceManager.
 @details   Specify before searching.
  */
+ (instancetype)sharedDeviceManagerWithType:(PFUDeviceType)deviceType;

/*! 
 @brief     Search for scanner.
 @param     productID   see ::ScanSnapProductID.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_SEARCH_DEVICE_FAIL,the localized description of the error will tell you what happend.
 @details   Search for scanner connected to the same network. Posted ::PFUDeviceManagerListOfDevicesDidChangeNotification when scanner is detected.
            If no scanner is detected, please try again.
  */
- (NSError *)searchForDevices:(ScanSnapProductID)productID;

/*! 
 @brief     Search for scanner using IP address.
 @param     ipAddress      IP address of scanner
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_SEARCH_DEVICE_FAIL, ::ERR_PARAM,the localized description of the error will tell you what happend.
 @details   Posted ::PFUDeviceManagerListOfDevicesDidChangeNotification when scanner is detected.
  */
- (NSError *)findDeviceUnicast:(NSString *)ipAddress;

/*! 
 @brief     Change log level of SDK.
 @param     logLevel    see ::LogModeLevel.
 @details   Posted ::PFUDeviceManagerLogOutputNotification when log in SDK is output.
  */
- (void)setLogLevel:(LogModeLevel)logLevel;
@end
/*!
 @brief     Posted when list of searched scanner is updated.
 @details   Use the property described in devices to get the infomation of detected scanners.
 */
PFU_EXTERN NSString * const PFUDeviceManagerListOfDevicesDidChangeNotification;
/*!
 @brief     Posted when connected scanner is changed.
 */
PFU_EXTERN NSString * const PFUDeviceManagerConnectedDeviceDidChangeNotification;
/*!
 @brief     Posted when SDK outputs log.
 @details   Use the keys described in 'Log Manager Key' to get object from the userInfo dictionary.
 */
PFU_EXTERN NSString * const PFUDeviceManagerLogOutputNotification;