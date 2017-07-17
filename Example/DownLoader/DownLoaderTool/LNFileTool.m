//
//  LNFileTool.m
//  DownLoader
//
//  Created by 宗丽娜 on 17/7/12.
//  Copyright © 2017年 nanaLxs. All rights reserved.
//

#import "LNFileTool.h"

@implementation LNFileTool
+(BOOL)fileExsits:(NSString *)filePath{

    if(filePath.length == 0){
    
        return NO;
    }else{
        return [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    }
    
}

+ (long long)fileSize:(NSString *)filePath {
    
    if (![self fileExsits:filePath]) {
        return 0;
    }
    
    NSDictionary *fileInfo = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    
    return [fileInfo[NSFileSize] longLongValue];
}



+ (void)moveFile:(NSString *)fromPath toPath:(NSString *)toPath {
    
    if (![self fileSize:fromPath]) {
        return;
    }
    
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
    
}

+ (void)removeFile:(NSString *)filePath {
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}



@end
