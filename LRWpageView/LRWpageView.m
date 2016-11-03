//
//  LRWpageView.m
//  9
//
//  Created by rwli on 16/11/2.
//  Copyright © 2016年 companyName. All rights reserved.
//

#import "LRWpageView.h"

@interface LRWpageView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

@end

@implementation LRWpageView

/**
 *  提供初始化nib的类方法
 *
 *
 */
+(instancetype)pageview{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    //添加自滚timer;
    NSTimer *timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(gun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
}
-(void)gun{
    CGFloat x =self.scrollview.contentOffset.x+self.scrollview.frame.size.width;
    if (x>self.scrollview.contentSize.width-self.scrollview.frame.size.width) {
        x=0;
    }
    [self.scrollview setContentOffset:CGPointMake(x, 0) animated:YES];


}
/**
 *  重写数据源get方法
 *
 *
 */
-(void)setImageNames:(NSArray<NSString *> *)imageNames{
    _imageNames =imageNames;
     [self.scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w=self.scrollview.frame.size.width;
    CGFloat h =self.scrollview.frame.size.height;
    for (int i=0; i<_imageNames.count; i++) {
        UIImageView *imgv =[[UIImageView alloc]initWithFrame:CGRectMake(w*i, 0, w, h)];
        imgv.image =[[UIImage imageNamed:_imageNames[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.scrollview addSubview:imgv];
    }
    self.scrollview.contentSize=CGSizeMake(w*_imageNames.count, h);
    self.pagecontrol.numberOfPages =_imageNames.count;

}

#pragma mark --UIScrollViewDelegate
/**
 *  实现分页功能
 *
 *
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int x =(scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    self.pagecontrol.currentPage=x;
    
}








@end
