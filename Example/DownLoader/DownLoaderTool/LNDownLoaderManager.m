//
//  LNDownLoaderManager.m
//  DownLoader
//
//  Created by 宗丽娜 on 17/7/17.
//  Copyright © 2017年 nanaLxs. All rights reserved.
//

#import "LNDownLoaderManager.h"
#import "NSString+LNMD5.h"
@interface LNDownLoaderManager()

@property (nonatomic, strong) NSMutableDictionary *downLoadInfo;

@end


@implementation LNDownLoaderManager

static LNDownLoaderManager * _loaderManager;
+(instancetype)shareInstance{
    
    if (!_loaderManager) {
        _loaderManager = [[LNDownLoaderManager alloc] init];
    }
    return _loaderManager;
    

};

+(instancetype)allocWithZone:(struct _NSZone *)zone{

    if (!_loaderManager) {
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            _loaderManager = [super allocWithZone:zone];
        });
    }
    return _loaderManager;

}

- (id)copyWithZone:(NSZone *)zone {
    return _loaderManager;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _loaderManager;
}
- (NSMutableDictionary *)downLoadInfo {
    if (!_downLoadInfo) {
        _downLoadInfo = [NSMutableDictionary dictionary];
    }
    return _downLoadInfo;
}


- (void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoadInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock {
    
    // 1. url
    NSString *urlMD5 = [url.absoluteString md5];
    
    // 2. 根据 urlMD5 , 查找相应的下载器
    LNDownLoader *downLoader = self.downLoadInfo[urlMD5];
    if (downLoader == nil) {
        downLoader = [[LNDownLoader alloc] init];
        self.downLoadInfo[urlMD5] = downLoader;
    }
    
    //    [downLoader downLoader:url downLoadInfo:downLoadInfo progress:progressBlock success:successBlock failed:failedBlock];
    
    __weak typeof(self) weakSelf = self;
    [downLoader downLoader:url downLoadInfo:downLoadInfo progress:progressBlock success:^(NSString *filePath) {
        
        [weakSelf.downLoadInfo removeObjectForKey:urlMD5];
        // 拦截block
        successBlock(filePath);
    } failed:failedBlock];
    
    
    
  
    
    
}


- (void)pauseWithURL:(NSURL *)url {
    
    NSString *urlMD5 = [url.absoluteString md5];
    LNDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader pauseCurrentTask];
}
- (void)resumeWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    LNDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader resumeCurrentTask];
}
- (void)cancelWithURL:(NSURL *)url {
    NSString *urlMD5 = [url.absoluteString md5];
    LNDownLoader *downLoader = self.downLoadInfo[urlMD5];
    [downLoader cacelCurrentTask];
    
}


- (void)pauseAll {
    
    [self.downLoadInfo.allValues performSelector:@selector(pauseCurrentTask) withObject:nil];
    
}
- (void)resumeAll {
    [self.downLoadInfo.allValues performSelector:@selector(resumeCurrentTask) withObject:nil];
}

@end
