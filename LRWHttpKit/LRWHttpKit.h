//
//  LRWHttpKit.h
//  sina
//
//  Created by rwli on 16/10/24.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <UIKit/UIKit.h>

@interface LRWHttpKit : NSObject

//定义网络请求回调block 

typedef void(^netsuccessblock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^netfaildblock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);



//我的方法申请，因该有，get post downnload, upload;;;;
+(void)HTTPWithGET:(NSString*)urlstr and:(NSDictionary*)parameters and:(netsuccessblock)success and:(netfaildblock)faild;

+(void)HTTPWithPOST:(NSString*)urlstr and:(NSDictionary*)parameters and:(netsuccessblock)success and:(netfaildblock)faild;




//增加一个网络监听方法
+(void)obbserverNetStatus;
//这是在view中心开菊花
+(void)configjuhua:(BOOL)yesorno forview:(UIView *)view;


@end
