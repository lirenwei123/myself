//
//  LRWflowayout.h
//  block
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 wyzc_lrw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRWflowayout : UICollectionViewFlowLayout

-(instancetype)initWithsize:(CGSize)myitemsize andHorV:(BOOL)isHorizontal andminlinespacing:(CGFloat)minlinespacing andminiteritemsspacing:(CGFloat)miniteritemsspacing andedgeinsets:(UIEdgeInsets)edgeinsets;


@end
