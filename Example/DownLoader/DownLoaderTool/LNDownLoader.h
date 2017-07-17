//
//  LNDownLoader.h
//  DownLoader
//
//  Created by 宗丽娜 on 17/7/12.
//  Copyright © 2017年 nanaLxs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LNDownLoadState){

    LNDownLoadStatePause,
    LNDownLoadStateDownLoading,
    LNDownLoadStatePauseSuccess,
    LNDownLoadStatePauseFailed
};

typedef void(^DownLoadInfoType)(long long totalSize);
typedef void(^ProgressBlockType)(float  progress);
typedef void(^SuccessBlockType)(NSString *filePath);
typedef void(^FailedBlockType)();
typedef void(^StateChangeType)(LNDownLoadState state);


@interface LNDownLoader : NSObject

/// 数据
@property (nonatomic, assign) LNDownLoadState state;
@property (nonatomic, assign) float progress;

@property (nonatomic, copy) DownLoadInfoType downLoadInfo;
@property (nonatomic, copy) StateChangeType stateChange;
@property (nonatomic, copy) ProgressBlockType progressChange;
@property (nonatomic, copy) SuccessBlockType successBlock;
@property (nonatomic, copy) FailedBlockType faildBlock;


-(void)downLoader:(NSURL *)url downLoadInfo:(DownLoadInfoType)downLoaderInfo progress:(ProgressBlockType)progressBlock success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock;



/**
 根据URL地址下载资源, 如果任务已经存在, 则执行继续动作
 @param url 资源路径
 */
- (void)downLoader:(NSURL *)url;
- (void)resumeCurrentTask;
/**
 暂停任务
 注意:
 - 如果调用了几次继续
 - 调用几次暂停, 才可以暂停
 - 解决方案: 引入状态
 */
- (void)pauseCurrentTask;

/**
 取消任务
 */
- (void)cacelCurrentTask;

/**
 取消任务, 并清理资源
 */
- (void)cacelAndClean;



@end



