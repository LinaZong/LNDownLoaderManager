//
//  LNViewController.m
//  DownLoader
//
//  Created by nanaLxs on 07/12/2017.
//  Copyright (c) 2017 nanaLxs. All rights reserved.
//

#import "LNViewController.h"
#import "LNDownLoaderManager.h"
@interface LNViewController ()
@property (weak, nonatomic) IBOutlet UIButton *downLoadBtn;
@property(nonatomic,strong)LNDownLoaderManager  * downLoader;



@end

@implementation LNViewController

-(LNDownLoaderManager *)downLoader{

    if (!_downLoader) {
        _downLoader = [LNDownLoaderManager shareInstance];
    }
    return _downLoader;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.downLoadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [self.downLoadBtn setTitle:@"暂停" forState:UIControlStateSelected];
	
    
}


- (IBAction)downLoad:(UIButton *)sender {
    
        NSURL * url = [NSURL URLWithString:@"http://free2.macx.cn:8281/tools/photo/SnapNDragPro418.dmg"];
    
   if (!sender.selected) {
    

////        
//        [self.downLoader downLoader:url downLoadInfo:^(long long totalSize) {
//            
//            NSLog(@"下载信息--%lld", totalSize);
//            
//        } progress:^(float progress) {
//          NSLog(@"下载进度--%f", progress);
//        } success:^(NSString *filePath) {
//            
//             NSLog(@"下载成功--路径:%@", filePath);
//        } failed:^{
//          NSLog(@"下载失败了");
//        }];
       
       [self.downLoader downLoader:url downLoadInfo:^(long long totalSize) {
          
             NSLog(@"下载信息--%lld", totalSize);
       } progress:^(float progress) {
         
            NSLog(@"下载进度--%f", progress);
       } success:^(NSString *filePath) {
       
           NSLog(@"下载成功--路径:%@", filePath);
       } failed:^{
          NSLog(@"下载失败了");
           
       }];
    
       
   }else{
   
       [self.downLoader pauseWithURL:url];
   
   
   }

    
    sender.selected = !sender.selected;
    
}

- (IBAction)cancleLoad:(UIButton *)sender {
     NSURL * url = [NSURL URLWithString:@"http://free2.macx.cn:8281/tools/photo/SnapNDragPro418.dmg"];
    
    [self.downLoader cancelWithURL:url];
}

- (IBAction)cancleAndClean:(UIButton * )sender {
    
     NSURL * url = [NSURL URLWithString:@"http://free2.macx.cn:8281/tools/photo/SnapNDragPro418.dmg"];
    [self.downLoader cancelWithURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
