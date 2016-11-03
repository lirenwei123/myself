//
//  LRWHttpKit.m
//  sina
//
//  Created by rwli on 16/10/24.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWHttpKit.h"
#import "SVProgressHUD.h"


@implementation LRWHttpKit

//创建一个 AFHTTPSessionManager 单例用来初始化一些方法，比如response的解析类型添加

+(AFHTTPSessionManager*)sharedLRWManager{
    
    //如果你要多次调用，就不要单利例，否则后面会出现空的manager
      AFHTTPSessionManager  *manager ;
    
            manager =[AFHTTPSessionManager manager];
        AFHTTPResponseSerializer *seria =[[AFHTTPResponseSerializer alloc]init];
        
        /**
         *  - `application/json`
         - `text/json`
         - `text/javascript`
         - `application/xml`
         - `text/xml`
         - `application/x-plist`
         - `image/tiff`
         - `image/jpeg`
         - `image/gif`
         - `image/png`
         - `image/ico`
         - `image/x-icon`
         - `image/bmp`
         - `image/x-bmp`
         - `image/x-xbitmap`
         - `image/x-win-bitmap`
         */
        NSArray *arry =@[@"text/plain",@"application/json",@"text/html"];
        NSMutableSet *set =[NSMutableSet setWithArray:arry];
        seria.acceptableContentTypes=set;
        manager.responseSerializer =seria;
    
    
    return manager;
}


#pragma mark--HTTPWithGET方法
+(void)HTTPWithGET:(NSString *)urlstr and:(NSDictionary *)parameters and:(netsuccessblock)success and:(netfaildblock)faild{
    [[self sharedLRWManager]GET:urlstr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        faild(task,error);
    }];
    
}
#pragma mark--HTTPWithPOST方法
+(void)HTTPWithPOST:(NSString *)urlstr and:(NSDictionary *)parameters and:(netsuccessblock)success and:(netfaildblock)faild{
   [[self sharedLRWManager]POST:urlstr parameters:parameters progress:nil
success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    success(task,responseObject);
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    faild(task,error);
}];

}
#pragma mark--obbserverNetStatus方法
+(void)obbserverNetStatus{
    AFNetworkReachabilityManager *netmanger =[AFNetworkReachabilityManager sharedManager];
    [netmanger startMonitoring];
    [netmanger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
//                AFNetworkReachabilityStatusUnknown          = -1,
//                AFNetworkReachabilityStatusNotReachable     = 0,
//                AFNetworkReachabilityStatusReachableViaWWAN = 1,
//                AFNetworkReachabilityStatusReachableViaWiFi = 2,
            case -1:
                NSLog(@"＝＝＝未知网络来自地球＝＝");
                break;
            case 0:
                NSLog(@"＝＝＝快点啊～网络怎么这么差啊＝＝");
                break;
            case 1:
                NSLog(@"＝＝＝有线网络不怕断＝＝");
                break;
            case 2:
                NSLog(@"=＝＝有wifi不用愁＝＝");
                break;
            default:
                break;
        }
    }];
}

+(void)configjuhua:(BOOL)yesorno forview:(UIView *)view{
    
#if 0
    if (yesorno) {
        UIActivityIndicatorView *juhua =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        juhua.backgroundColor =[UIColor greenColor];
        juhua.center =view.center;
        juhua.color =[UIColor redColor];
        juhua.tag=-1024;
        [view addSubview:juhua];
        [juhua startAnimating];
    }else{
        UIActivityIndicatorView *juhua =[view viewWithTag:-1024];
        [juhua stopAnimating];
        [juhua removeFromSuperview];
    }
#endif
    //
#if 1
    if (yesorno) {
        [SVProgressHUD show];
    }else{
        [SVProgressHUD dismiss];
    }
    
#endif
    
   }


@end
