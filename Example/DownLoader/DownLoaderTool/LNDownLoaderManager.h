//
//  LNDownLoaderManager.h
//  DownLoader
//
//  Created by 宗丽娜 on 17/7/17.
//  Copyright © 2017年 nanaLxs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNDownLoader.h"
@interface LNDownLoaderManager : NSObject
+(instancetype)shareInstance;


- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;


- (void)pauseWithURL:(NSURL *)url;
- (void)resumeWithURL:(NSURL *)url;
- (void)cancelWithURL:(NSURL *)url;


- (void)pauseAll;
- (void)resumeAll;

@end
