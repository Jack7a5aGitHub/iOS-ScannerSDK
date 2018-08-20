//
//  SSSDKUtil.m
//  LoadScannerDataSample
//
//  Created by Jack Wong on 2018/08/08.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

#import "SSSDKUtil.h"

@implementation SSSDKUtil

+ (NSArray *)getFilesInDirectory:(NSString *)directory allowedFileSuffixes:(NSArray *)allowedFileSuffixes createDirectories:(BOOL)createDirectories {
    NSFileManager    *fileManager    = [NSFileManager defaultManager];
    NSArray            *arrPath        = nil;
    NSMutableArray    *arrFiles        = nil;
    NSString        *fullPath        = nil;
    
    if (createDirectories == YES && [fileManager fileExistsAtPath:directory]) {
        [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    arrPath = [fileManager contentsOfDirectoryAtPath:directory error:nil];
    arrFiles = [NSMutableArray arrayWithCapacity:arrPath.count];
    fullPath = nil;
    
    for (NSString *path in arrPath) {
        fullPath = [directory stringByAppendingPathComponent:path];
        for (NSString *pathCompoment in allowedFileSuffixes) {
            if ([[path pathExtension] isEqualToString:pathCompoment] == YES) {
                [arrFiles addObject:fullPath];
                break;
            }
        }
    }
    return arrFiles;
}

@end
