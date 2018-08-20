//
//  SSSDKUtil.h
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSSDKUtil : NSObject

+ (NSArray *)getFilesInDirectory:(NSString *)directory allowedFileSuffixes:(NSArray *)allowedFileSuffixes createDirectories:(BOOL)createDirectories;

@end
