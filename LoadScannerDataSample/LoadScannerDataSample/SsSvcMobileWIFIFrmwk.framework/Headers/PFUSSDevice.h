/************************************************************************
 *	File name		:SSDevice.h
 *	Program name	:SsSvcMobileWIFIFrmwk
 *	ALL RIGHTS RESERVED,COPYRIGHT(C) PFU LIMITED 2014
 ************************************************************************/
#import <Foundation/Foundation.h>
#import "PFUDevice.h"

/*! 
 @discussion    Options for Image quality
  */
typedef enum{
    /*! 
     @brief     Auto(default)
      */
    PFUImageQualityOptionAuto      = 0,
    /*! 
     @brief     Normal
      */
    PFUImageQualityOptionNormal    = 1,
    /*! 
     @brief     Fine
      */
    PFUImageQualityOptionFine      = 2,
    /*! 
     @brief     Super Fine
      */
    PFUImageQualityOptionSuperFine = 3,
}PFUImageQualityOption;


/*! 
 @discussion    Options for Color mode
 
 When [Auto] is selected, each document will be determined as color or gray automatically. When the file format is JPEG, [Auto] will be selected.
  */
typedef enum{
    /*! 
     @brief     Auto(default)
      */
    PFUColorModeOptionAuto     = 0,
    /*! 
     @brief     Color
      */
    PFUColorModeOptionColor    = 1,
    /*! 
     @brief     Gray
      */
    PFUColorModeOptionGray     = 2,
    /*! 
     @brief     B&W
      */
    PFUColorModeOptionBW       = 3,
}PFUColorModeOption;


/*! 
 @discussion    Options for Brightness (B&W)
 
 Lower value decreases/higher value increases the brightness.
  */
typedef enum{
    /*! 
     @brief     -5
      */
    PFUBrightnessOptionLevel1   = -5,
    /*! 
     @brief     -4
      */
    PFUBrightnessOptionLevel2   = -4,
    /*! 
     @brief     -3
      */
    PFUBrightnessOptionLevel3   = -3,
    /*! 
     @brief     -2
      */
    PFUBrightnessOptionLevel4   = -2,
    /*! 
     @brief     -1
      */
    PFUBrightnessOptionLevel5   = -1,
    /*! 
     @brief     0(default)
      */
    PFUBrightnessOptionLevel6   = 0,
    /*! 
     @brief     1
      */
    PFUBrightnessOptionLevel7   = 1,
    /*! 
     @brief     2
      */
    PFUBrightnessOptionLevel8   = 2,
    /*! 
     @brief     3
      */
    PFUBrightnessOptionLevel9   = 3,
    /*! 
     @brief     4
      */
    PFUBrightnessOptionLevel10  = 4,
    /*! 
     @brief     5
      */
    PFUBrightnessOptionLevel11  = 5,
}PFUBrightnessOption;


/*! 
 @discussion    Options for Scanning side
 
   In case of iX100, the configuration for Both sides is disregarded and scan is performed by configuration for One side.
  */
typedef enum{
    /*! 
     @brief     One side(iX100:default)
      */
    PFUScanningSideOptionOneSurface    = 0,
    /*! 
     @brief     Both sides(iX500:default)
      */
    PFUScanningSideOptionBothSurfaces  = 1,
}PFUScanningSideOption;



/*! 
 @discussion    Options for File format
  */
typedef enum{
    /*! 
     @brief     JPEG
      */
    PFUFileFormatOptionJpeg    = 0,
    /*! 
     @brief     PDF(default)
      */
    PFUFileFormatOptionPdf     = 1,
}PFUFileFormatOption;



/*! 
 @discussion    Options for Paper size
  */
typedef enum{
    /*! 
     @brief     Auto(default)
      */
    PFUPaperSizeOptionAuto         = 0,
    /*! 
     @brief     Letter
      */
    PFUPaperSizeOptionLetter       = 1,
    /*! 
     @brief     Legal
      */
    PFUPaperSizeOptionLegal        = 2,
    /*! 
     @brief     A4
      */
    PFUPaperSizeOptionA4           = 3,
    /*! 
     @brief     A5
      */
    PFUPaperSizeOptionA5           = 4,
    /*! 
     @brief     A6
      */
    PFUPaperSizeOptionA6           = 5,
    /*! 
     @brief     B5
      */
    PFUPaperSizeOptionB5           = 6,
    /*! 
     @brief     B6
      */
    PFUPaperSizeOptionB6           = 7,
    /*! 
     @brief     Card
      */
    PFUPaperSizeOptionCard         = 8,
    /*! 
     @brief     Business Card
      */
    PFUPaperSizeOptionBusinessCard = 9,
}PFUPaperSizeOption;


/*! 
 @discussion     Options for Compression rate
 
 Lower compression value increases file size.
  */
typedef  enum{
    /*! 
     @brief     Weak
      */
    PFUCompressionOptionLevel1   = 1,
    /*! 
     @brief     Slightly Weak
      */
    PFUCompressionOptionLevel2   = 2,
    /*! 
     @brief     Standard(default)
      */
    PFUCompressionOptionLevel3   = 3,
    /*! 
     @brief     Slightly Strong
      */
    PFUCompressionOptionLevel4   = 4,
    /*! 
     @brief     Strong
      */
    PFUCompressionOptionLevel5   = 5,
}PFUCompressionOption;

/*! 
 @discussion     Options for Skip blank page
  */
typedef enum{
    /*! 
     @brief     OFF
      */
    PFUBlankRemoveOptionOFF   = 0,
    /*! 
     @brief     ON(default)
      */
    PFUBlankRemoveOptionON   = 1,
}PFUBlankRemoveOption;

/*! 
 @discussion    Options for Reduce bleed-through
  */
typedef enum{
    /*! 
     @brief     OFF(default)
      */
    PFUBleedThroughOptionOFF   = 0,
    /*! 
     @brief     ON
      */
    PFUBleedThroughOptionON   = 1,
}PFUBleedThroughOption;


/*! 
 @discussion    Options for Multifeed
 
 In case of iX100, the configuration ON is disregarded and scan is performed by configuration OFF.
  */
typedef enum{
    /*! 
     @brief     OFF(iX100:default)
      */
    PFUMultiFeedOptionOFF   = 0,
    /*! 
     @brief     ON(iX500:default)
      */
    PFUMultiFeedOptionON   = 1,
}PFUMultiFeedOption;

/*!
 @discussion    Status of scanner
 */
typedef enum
{
    /*!
     @brief     The scanner has been disconnected.
     */
    SSDeviceStatusDisconnected,
    /*!
     @brief     Disconnecting the scanner.
     */
    SSDeviceStatusDisconnecting,
    /*!
     @brief     Connecting the scanner.
     */
    SSDeviceStatusAttemptingConnection,
    /*!
     @brief     The scanner has been connected.
     */
    SSDeviceStatusConnected,
    /*!
     @brief     The scanner is scanning.
     */
    SSDeviceStatusScanning,
    /*!
     @brief     The scanner is waiting for scanning.(Only iX100)
     */
    SSDeviceStatusWaitingScan,
    /*!
     @brief     The scanner has paused for multifeed error.
     */
    SSDeviceStatusPausedForMultifeed,
    /*!
     @brief     The scanner has paused for scanning error.
     */
	SSDeviceStatusPausedForError
}SSDeviceStatus;

/*!
 @discussion    Error codes
 */
typedef enum{
    /*!
     @brief     No error happened.
     */
	ERR_NOERR                               = 0,
    /*!
     @brief     Params error.
     */
	ERR_PARAM                               = -1,
    /*!
     @brief     Unexpected sdk error.
     @details   Restart the application, and try again.
     */
    ERR_UNEXPECTED_SW_ERROR                 = -2,
    /*!
     @brief     Unexpected scanner error.
     @details   Turn on ScanSnap and run the process.
     */
    ERR_UNEXPECTED_HW_ERROR                 = -3,
    
    /*!
     @brief     The device is reserved by other application.
     @details   End the application, and try again.
     */
	ERR_DEVICE_USED                         = -1001,
    /*!
     @brief     The password specified by user application is incorrect.
     @details   Enter a correct password, and try again.
     */
    ERR_WRONG_PASSWORD                      = -1002,
    /*!
     @brief     The password is invalid.
     @details   Enter a correct password, and try again.
     */
    ERR_INVALID_PASSWORD                    = -1003,
    /*!
     @brief     Has connected other device.
     */
    ERR_HAS_OTHER_DEVICE_CONNECTED          = -1004,
    
    /*!
     @brief     The device detected a paper jam.
     @details   Open the ADF top section/top cover on ScanSnap to remove the document, and then try scanning again.
     */
    ERR_PAPER_JAM                           = -2001,
    /*!
     @brief     The top cover is open.
     @details   Close the ADF top section/top cover, and try scanning again.
     */
    ERR_TOP_COVER_OPEN                      = -2002,
    /*!
     @brief     The document feeder is empty when a new scan starts.
     @details   Load the document in the ADF paper chute (cover)/feed guide, and try scanning again.
     */
    ERR_DOCUMENT_FEEDER_EMPTY               = -2003,
    /*!
     @brief     The folder specified by user application is invalid.
     @details   Check the following and try again:- The save location exists.- You are authorized to write to the save location.
     */
    ERR_INVALID_SAVE_FOLDER                 = -2004,
    /*!
     @brief     The image data save failed.
     @details   Restart the application, and try again.
     */
    ERR_SAVE_IMAGE                          = -2005,
    /*!
     @brief     There is insufficient disk space in the specified save folder.
     @details   Delete unnecessary files, and try scanning again.
     */
    ERR_NO_DISK_SPACE                       = -2006,
    /*!
     @brief     The PDF file reached the file size limit (2GB).
     @details   Save the scanned data. Resume scanning from the document page which was not saved.
     */
    ERR_FILE_SIZE_LIMIT                     = -2007,
    /*!
     @brief     The wireless network connection is not good enough to communicate.
     @details   Check the following and try again:- ScanSnap is on.- Wi-Fi switch on ScanSnap is on.- Mobile device is connected to a network.
     */
    ERR_BAD_NETWORK_CONNECTION              = -2008,
    /*!
     @brief     A3 Carrier Sheet is detected.Not Support A3 CS.
     @details   Carrier Sheet is not supported. Try scanning again without using a Carrier Sheet.
     */
    ERR_A3_CARRIER_SHEET_DETECTED           = -2009,
    /*!
     @brief     All papers recognized as blank.
     @details   Confirm the scanning side(s), and try again.
     */
    ERR_ALL_BLANK_PAGES                     = -2010,
    
    /*!
     @brief     IX100 battery high temperature.
     @details   Unplug all the connected cables and plug them back in. Wait for a while, and then try scanning again.
     */
    ERR_BATTERY_TEMPERATURE                 = -2011,
    /*!
     @brief     IX100 press scan button to emergency stop when scanner is scanning.
     @details   Open the ADF top section/top cover on ScanSnap to remove the document, and then try scanning again.
     */
    ERR_EMERGENCY_STOP                      = -2012,
    
    /*!
     @brief     Already in scan session.
     */
    ERR_ALREADY_IN_SCAN_SESSION             = -3001,
    /*!
     @brief     Device not connected.
     */
    ERR_DEVICE_NOT_CONNECTED                = -3002,
    /*!
     @brief     Not in scan session.
     */
    ERR_NOT_IN_SCAN_SESSION                 = -3003,
    /*!
     @brief     Scan session can not be continue.
     */
    ERR_DO_NOT_CONTINUE_SCAN                = -3004,
    /*!
     @brief     Device is scanning.
     */
    ERR_DEVICE_IS_SCANNING                  = -3005,
    /*!
     @brief     Save pdf file failed when end scan session.
     */
    ERR_PDF_FILE_SAVE_FAIL                  = -3006,
    /*!
     @brief     Do not detect multifeed error.
     */
    ERR_DO_NOT_DETECT_MULTIFEED_PAGE        = -3007,
    /*!
     @brief     Had removed multifeed already.
     */
    ERR_HAD_REMOVED_MULTIFEED_PAGE          = -3008,
    /*!
     @brief     Sequence is wrong.
     */
    ERR_SEQUENCE_ERROR                      = -3009,
    
    /*!
     @brief     Search device failed error.
     */
    ERR_SEARCH_DEVICE_FAIL                  = -4001,
	
}SSErrorStatus;

/*!
 The ::PFUSSDevice class added detailed device's properties,and methods for scanning paper.
  */
@interface PFUSSDevice : PFUDevice

/*! 
 @brief      IP address of scanner(read-only)
  */
@property(nonatomic, readonly) NSString *ipAddress;

/*! 
 @brief     Password of scanner
 
 The default value is nil. In this case, connect with the default password of scanner.
  */
@property(nonatomic, retain) NSString *password;

/*! 
 @brief     Status of scanner(read-only)
  */
@property(nonatomic, readonly) SSDeviceStatus scanStatus;

/*! 
 @brief     ProductID of scanner(read-only)
  */
@property(nonatomic, readonly) NSString *productID;

/*!
 @brief     Start scan session.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_DEVICE_NOT_CONNECTED, ::ERR_ALREADY_IN_SCAN_SESSION,the localized description of the error will tell you what happend.
 @note      Make sure scanner status is 'connected' but not in scan session before you call this method. You need to call PFUSSDevice::endScanSession, when scan session ends.
  */
- (NSError *)beginScanSession;

/*! 
 @brief     End scan session.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_PDF_FILE_SAVE_FAIL, ::ERR_NOT_IN_SCAN_SESSION, ::ERR_DEVICE_IS_SCANNING,the localized description of the error will tell you what happend.
 @details   Posted ::SSDevicePDFFilePathNotification when file format is PDF and scanning is completed.
 @note      Make sure the scanner is in scan session and scanner status is not 'scanning' before you call this method.
  */
- (NSError *)endScanSession;

/*! 
 @brief     Start scan.
 @param     settings   Scan settings with 'Scan Settings Keys', the save folder path should exist and should be writable, or you can not start scan.If the other scan settings are not done or if the value is incorrect, the default values will be used for scanning.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_DEVICE_NOT_CONNECTED, ::ERR_DEVICE_IS_SCANNING, ::ERR_INVALID_SAVE_FOLDER, ::ERR_NOT_IN_SCAN_SESSION, ::ERR_DO_NOT_CONTINUE_SCAN,the localized description of the error will tell you what happend.
 @details   Posted ::SSDeviceDidScanPageNotification when the scanner scans one sheet. Also, posted ::SSDeviceDidFinishScanNotification when the scanner finishes scanning. Posted ::SSDeviceDidErrorDuringScanNotification when an error occurs on the scanner during scan.
 @note      Make sure to call PFUSSDevice::beginScanSession first and scanner status is 'connected' before you call this method.Control your app so as not to sleep automatically after scanning starts.If your app is in the background state, disconnect the scanner. Otherwise, an unexpected error may occur.
  */
- (NSError *)scanDocuments:(NSDictionary *)settings;

/*! 
 @brief     Remove multifed images.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_DEVICE_NOT_CONNECTED, ::ERR_DO_NOT_DETECT_MULTIFEED_PAGE, ::ERR_NOT_IN_SCAN_SESSION, ::ERR_HAD_REMOVED_MULTIFEED_PAGE,the localized description of the error will tell you what happend.
 @note      Make sure scanner status is 'pausedForMultifeed' and the file format is PDF before you call this method.
  */
- (NSError *)removeMultifeedDetectedPage;

/*! 
 @brief     Cancel scan.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_SEQUENCE_ERROR, ::ERR_NOT_IN_SCAN_SESSION,the localized description of the error will tell you what happend.
 @details   Posted ::SSDeviceDidFinishScanNotification when it succeeds. You can call scanDocuments to continue scan.
 @note      Make sure scanner status is 'scanning'.
  */
- (NSError *)cancelScan;

/*! 
 @brief     Get scanner info.
 @return    If succeeded, return nil; If an error occurs, return NSError object with one of the codes below. See ::SSErrorStatus for more.
            ::ERR_DEVICE_NOT_CONNECTED, ::ERR_ALREADY_IN_SCAN_SESSION,the localized description of the error will tell you what happend.
 @details   Posted ::SSDeviceInfoDidReceiveNotification when it succeeds.
 @note      Make sure scanner status is 'connected' and not in scan session before you call this method.

  */
- (NSError *)getScannerInfo;
@end







#pragma mark - Notification
/** @name    Notifications
 *@{
 */
/*!
 @brief     Posted when the scanner status has been changed.
 @details   Use the property described in scanStatus to get scanner status.
 
 It is recommended that you change the UI status of your app by scanStatus.
 */
PFU_EXTERN NSString * const SSDeviceStatusDidChangeNotification;
/*!
 @brief     Posted when scanner scan button has pressed and scanner status is 'connected' or 'pausedForMultifeed'.
 @details   It is recommended that you call PFUSSDevice::scanDocuments: and countiue scanning. In case of iX100, it is recommended that you call PFUSSDevice::endScanSession and finish scanning after all documents are scanned.
 */
PFU_EXTERN NSString * const SSDeviceDidPressScanButtonNotification;
/*!
 @brief  Posted when the scanner turned off.
 */
PFU_EXTERN NSString * const SSDeviceDidPowerOffNotification;
/*!
 @brief     Posted when the scanner scanned a page.
 @details   Use the keys described in 'Page Info Keys' to get objects from the userInfo dictionary.
 */
PFU_EXTERN NSString * const SSDeviceDidScanPageNotification;
/*!
 @brief     Posted when the scanner paused for multifeed.
 @details   Use the method described in PFUSSDevice::removeMultifeedDetectedPage to delete a multifed page.
 */
PFU_EXTERN NSString * const SSDeviceDidPauseForMultifeedNotification;
/*!
 @brief     Posted when an error occurs on the scanner during scan.
 @details   Use the keys described in 'SDK Error Key' to get object from the userInfo dictionary.
  You can get the NSError object with one of the codes below.
 ::ERR_PAPER_JAM, ::ERR_TOP_COVER_OPEN, ::ERR_DOCUMENT_FEEDER_EMPTY, ::ERR_A3_CARRIER_SHEET_DETECTED, ::ERR_ALL_BLANK_PAGES, ::ERR_EMERGENCY_STOP,
 ::ERR_INVALID_SAVE_FOLDER, ::ERR_NO_DISK_SPACE, ::ERR_FILE_SIZE_LIMIT, ::ERR_SAVE_IMAGE, ::ERR_BAD_NETWORK_CONNECTION, ::ERR_BATTERY_TEMPERATURE, ::ERR_UNEXPECTED_SW_ERROR, ::ERR_UNEXPECTED_HW_ERROR,The NSError object containing the localized explanation of the reason and recovery suggestion.
 
 If the error is uncontinuable (Scanner status is 'PausedForError'), you must call PFUSSDevice::endScanSession and finish the scanning.
 If the error is continuable, you can call PFUSSDevice::scanDocuments: and countiue the scanning.
 */
PFU_EXTERN NSString * const SSDeviceDidErrorDuringScanNotification;
/*!
 @brief     Posted when the scanner finished scanning.
 @details   It is recommended that you call PFUSSDevice::endScanSession and finish scanning. In case of iX100, it is recommended that you countiue scanning.
 */
PFU_EXTERN NSString * const SSDeviceDidFinishScanNotification;
/*!
 @brief     Posted when the scanner got wifi status info.
 @details   Use the keys described in 'Scanner Info Keys' to get object from the userInfo dictionary.
 */
PFU_EXTERN NSString * const SSDeviceInfoDidReceiveNotification;
/*!
 @brief     Posted when pdf file is created.
 @details   Use the keys described in 'PDF File Path Key' to get object from the userInfo dictionary.
 */
PFU_EXTERN NSString * const SSDevicePDFFilePathNotification;
/**
 *@}
 */

#pragma mark - SDK Error Key
/** @name    SDK Error Key
 *@{
 */
/*!
 @brief     Key for device error
 @details   The key for an NSError object containing a ::SSErrorStatus constant.
 */
PFU_EXTERN NSString * const SSDeviceErrorKey;
/**
 *@}
 */

#pragma mark - ScannerInfo
/** @name    Scanner Info Keys
 *@{
 */
/*!
 @brief     Key for scanned page count
 @details   The key for an NSNumber object, showing number of ever-scanned page in the scanner
 */
PFU_EXTERN NSString * const SSDeviceTotalScannedPageCountKey;
/*!
 @brief     Key for roller set count
 @details   The key for an NSNumber object, showing number of scanned page since the roller was replaced and the count was reset
            This key is not available with iX100.
 */
PFU_EXTERN NSString * const SSDeviceRollerSetCountKey;
/*!
 @brief     Key for wifi strengh
 @details   The key for an NSNumber object, showing strength of Wi-Fi signal
 
 The legal value is 0x01(Weak), 0x02(Medium), 0x03(Strong), 0x10(Direct connect mode).
 */
PFU_EXTERN NSString * const SSDeviceWifiStrenghKey;
/*!
 @brief     Key for battery level
 @details   The key for an NSNumber object, showing percentage of remaining bettery level
            This key is available with iX100 only.
 
  The range of legal value is between 0x00(0%) and 0x64(100%).
 */
PFU_EXTERN NSString * const SSDeviceBatteryLevelKey;
/*!
 @brief     key for firmware version
 @details   The key for an NSString object, showing version number of scanner firmware
 */
PFU_EXTERN NSString * const SSDeviceFirmwareVersionKey;
/**
 *@}
 */

#pragma mark - PageInfo
/** @name    Page Info Keys
 *@{
 */
/*!
 @brief     Key for page info file front path
 @details   The key for an NSString object
 A file path of front side image saved in a specific folder
 When blank removal option is ON and the scanned page is blank, this key will be NSNull.
 */
PFU_EXTERN NSString * const SSDevicePageInfoFilePathFrontKey;
/*!
 @brief     Key for page info file back path
 @details   The key for an NSString object
 A file path of back side image saved in a specific folder.
 When blank removal option is ON and the scanned page is blank, this key will be NSNull.
 In case of single-sided scanning, this key is not included in DidScanPage notification.
 */
PFU_EXTERN NSString * const SSDevicePageInfoFilePathBackKey;
/*!
 @brief     Key for page info file front blank
 @details   The key for an NSNumber object. This page is blank if this value is 1. This page is not blank if this value is 0.
 Key of whether the front side image is blank or not.
 */
PFU_EXTERN NSString * const SSDevicePageInfoBlankFrontKey;
/*!
 @brief     Key for page info file back blank
 @details   The key for an NSNumber object. This page is blank if this value is 1. This page is not blank if this value is 0.
 Key of whether the back side image is blank or not
 In case of single-sided scanning, this key is not included in DidScanPage notification.
 */
PFU_EXTERN NSString * const SSDevicePageInfoBlankBackKey;
/*!
 @brief     Key for page info file number
 @details   The key for an NSNumber object.
 Containing a page number counting up until endScanSession is called
 The number is increased by 1 per paper regardless of scanning side setting.
 */
PFU_EXTERN NSString * const SSDevicePageInfoPageNoKey;
/**
 *@}
 */

#pragma mark - Settings
/** @name    Scan Settings Keys
 *@{
 */
/*!
 @brief     Key for paper size setting
 @details   The key for an NSNumber object containing a ::PFUPaperSizeOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingPaperSizeKey;
/*!
 @brief     Key for file format setting
 @details   The key for an NSNumber object containing a ::PFUFileFormatOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingFileFormatKey;
/*!
 @brief     Key for color mode setting
 @details   The key for an NSNumber object containing a ::PFUColorModeOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingColorModeKey;
/*!
 @brief     Key for brightness setting
 @details   The key for an NSNumber object containing a ::PFUBrightnessOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingBrightnessKey;
/*!
 @brief     Key for image quality setting
 @details   The key for an NSNumber object containing a ::PFUImageQualityOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingImageQualityKey;
/*!
 @brief     Key for compression setting
 @details   The key for an NSNumber object containing a ::PFUCompressionOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingCompressionKey;
/*!
 @brief     Key for scanning side setting
 @details   The key for an NSNumber object containing a ::PFUScanningSideOption constant

 */
PFU_EXTERN NSString * const SSDeviceScanSettingScanningSideKey;
/*!
 @brief     Key for blank removal setting
 @details   The key for an NSNumber object containing a ::PFUBlankRemoveOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingBlankRemovalKey;
/*!
 @brief     Key for bleed through setting
 @details   The key for an NSNumber object containing a ::PFUBleedThroughOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingBleedThroughKey;
/*!
 @brief     Key for multifeed setting
 @details   The key for an NSNumber object containing a ::PFUMultiFeedOption constant
 */
PFU_EXTERN NSString * const SSDeviceScanSettingMultiFeedKey;
/*!
 @brief     Key for save folder setting
 @details   The key for an NSString object
 */
PFU_EXTERN NSString * const SSDeviceScanSettingSaveFolderKey;
/**
 *@}
 */

#pragma mark - LogManager
/** @name    Log Manager Key
 *@{
 */
/*!
 @brief     Key for log manager
 @details   The key for an NSString object, showing detailed logs in SDK
 
 Output the SDK log as well in the log file to be output from your app.
 */
PFU_EXTERN NSString * const SSDeviceLogManagerLogKey;
/**
 *@}
 */
#pragma mark - PDF File Path

/** @name    PDF File Path Key
 *@{
 */
/*!
 @brief     Key for return pdf file path
 @details   The key for an NSString object, showing a PDF file path. This is availble for PDF scanning.
 */
PFU_EXTERN NSString * const SSDevicePDFFilePathKey;
/**
 *@}
 */





