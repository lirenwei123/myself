//
//  objcBlockbyLRW.m
//  sina
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "objcBlockbyLRW.h"








/**
 *  LRWsetviewBlcok 给一个view上属性
 *
 *  @param sender     传一个view进来
 *  @param color      颜色
 *  @param rect       尺寸
 *  @param center     中心
 *  @param corradious 圆角
 *
 *  @return 无返回类型viod
 */
const LRWsetUIviewblock LRWsetviewBlcok=^(UIView*sender,UIColor *color,CGRect rect,CGFloat corradious){
    sender.backgroundColor =color;
    sender.frame =rect;
    sender.layer.masksToBounds=YES;
    sender.layer.cornerRadius =corradious;
    sender.layer.masksToBounds=YES;
    
};
/**
 *  LRWsetAnimationgrouBlock 给view上一个动画组transform.translation.y／transform.scale／transform.rotation
 *
 *  @param sender   传一个view进来
 *  @param postionY y轴的动画距离
 *  @param scale    伸缩比例
 *  @param rotation 旋转角度
 *  @param duration 动画时长
 *
 *  @return 无返回类型viod
 */
const LRWsetAnimationBlock LRWsetAnimationgrouBlock=^(UIView*sender,CGFloat postionY,CGFloat scale,CGFloat rotation,CGFloat duration){
    NSMutableArray *arry =@[].mutableCopy;
    for(int i=0;i<3;i++){
        CABasicAnimation *a =[CABasicAnimation animation];
        switch (i) {
            case 0:
                a.keyPath = @"transform.translation.y";
                a.toValue=@(postionY);
                break;
            case 1:
                a.keyPath = @"transform.scale.x";
                a.toValue=@(scale);
                break;
            case 2:
                a.keyPath = @"transform.rotation.x";
                a.toValue=@(rotation);
                break;
            default:
                break;
        }
        [arry addObject:a];
}
    CAAnimationGroup *group =[CAAnimationGroup animation];
    group.animations =arry;
    group.duration =duration;
    group.removedOnCompletion =NO;
    [sender.layer addAnimation:group forKey:nil];
};








@implementation objcBlockbyLRW

//实现九宫格
/**
 *  objcBlockbyLRW九宫格类方法
 *
 *  @param Hnum     这是一行多少个view
 *  @param Vnum     这是一列多少个view
 *  @param viewSize 这是view的size
 *  @param view     需要添加到哪个view上
 */
+(void)jiugonggewithHnum:(NSInteger)Hnum Vnum:(NSInteger)Vnum viewSize:(CGSize)viewSize onwhoseView:(UIView*)view{
    CGFloat x = (view.frame.size.width-viewSize.width*Hnum)/(Hnum-1)+viewSize.width;
    CGFloat y =(view.frame.size.height-viewSize.height*Vnum)/(Vnum-1)+viewSize.height;
    
    
    for (int i=0; i<Hnum*Vnum ; i++) {
        
        if (Hnum>1&Vnum>1) {
            UIView *v =[[UIView alloc]init];
            CGRect rect=CGRectMake(i%Hnum*x, i/Hnum*y, viewSize.width, viewSize.height);
            
                       //在这里做一些动画之类的事情，先上属性，然后动画
            LRWsetviewBlcok(v,kRandomeColor,rect,viewSize.width*0.5);
            [view addSubview:v];
            LRWsetAnimationgrouBlock(v,50,0.2,3.14,5);
            
        }else{ //需要排除一些特殊条件
            if (Hnum==1&Vnum>1) {
                
                x =(view.frame.size.width-viewSize.width)*0.5;
                UIView *v =[[UIView alloc]init];
                CGRect rect=CGRectMake(x, i*y, viewSize.width, viewSize.height);
                LRWsetviewBlcok(v,kRandomeColor,rect,Hnum*0.5);
                LRWsetAnimationgrouBlock(v,50,0.2,3.14,5);
                [view addSubview:v];
            }
            
            else if(Vnum==1&Hnum>1){
                y=(view.frame.size.height-viewSize.height)*0.5;
                UIView *v =[[UIView alloc]init];
                CGRect rect=CGRectMake(i*x, y, viewSize.width, viewSize.height);
                LRWsetviewBlcok(v,kRandomeColor,rect,Hnum*0.5);
                LRWsetAnimationgrouBlock(v,50,0.2,3.14,5);
                [view addSubview:v];
                
            }else{
                UIView *v =[[UIView alloc]init];
                CGRect rect=CGRectMake(0, 0, viewSize.width, viewSize.height);
                v.center=view.center;
                LRWsetviewBlcok(v,kRandomeColor,rect,Hnum*0.5);
                LRWsetAnimationgrouBlock(v,50,0.2,3.14,5);
                [view addSubview:v];
            }
        }
    }
}



@end

