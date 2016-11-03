//
//  LRWflowayout.m
//  block
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 wyzc_lrw. All rights reserved.
//

#import "LRWflowayout.h"



@interface LRWflowayout()

@property (assign,nonatomic)NSInteger allcount;
@property (assign,nonatomic)CGSize motherSize;
@property (strong,nonatomic)NSMutableArray *attriarry;
@property (assign,nonatomic)CGSize myitemsize;
@property (assign,nonatomic)BOOL  isHorizontal;
@property (assign,nonatomic)CGFloat minlinespacing;
@property (assign,nonatomic)CGFloat miniteritemsspacing;
@property (assign,nonatomic)UIEdgeInsets edgeinsets;


@end

@implementation LRWflowayout
{
    int heng ;
    int shu ;
}

-(instancetype)initWithsize:(CGSize)myitemsize andHorV:(BOOL)isHorizontal andminlinespacing:(CGFloat)minlinespacing andminiteritemsspacing:(CGFloat)miniteritemsspacing andedgeinsets:(UIEdgeInsets)edgeinsets{
    if (self =[super init]) {
        _myitemsize =myitemsize;
        _isHorizontal =isHorizontal;
        _minlinespacing =minlinespacing;
        _miniteritemsspacing=miniteritemsspacing;
        _edgeinsets =edgeinsets;
    }
    return self;
}
-(void)prepareLayout{
    //    NSLog(@"准备布局");
    _allcount =[self.collectionView numberOfItemsInSection:0];
    _motherSize =self.collectionView.bounds.size;
    
    //    NSLog(@"_allcount = %ld",_allcount);
    //    NSLog(@"dataSource = %@",self.collectionView.dataSource);
    _attriarry =@[].mutableCopy;
    
    

    
    heng =(self.motherSize.width-_edgeinsets.left+_miniteritemsspacing)/(self.myitemsize.width+_miniteritemsspacing);
    if (heng==0) {//整除不了就nil
        heng=1;
    }
    shu =(self.motherSize.height-_edgeinsets.top+_minlinespacing)/(self.myitemsize.height+_minlinespacing);
    if (shu==0) {
        shu=1;
    }
    
//     MYLog(@"--%ld %ld",heng,shu);
//    xoffset =(_motherSize.width-self.myitemsize.width*heng)/(heng+1);
//    yoffset =(_motherSize.height-self.myitemsize.height*shu)/(shu+1);
    
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    for (int i=0; i<_allcount ; i++) {
        UICollectionViewLayoutAttributes *attr=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
//               attr.transform3D =CATransform3DRotate(attr.transform3D, 0.14, 0.15, 0.16, 0.5);
    
        [_attriarry addObject:attr];
        
    }
    
        
   
    return _attriarry;
}

-(UICollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attr =[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    
    if (self.isHorizontal) {
        
        //算出line间隔
        
        CGFloat offsety ;
       
        
        if (shu>1) {
            offsety =(self.collectionView.frame.size.height-_edgeinsets.top-_edgeinsets.bottom-_myitemsize.height*shu)/(shu-1);
            attr.frame =CGRectMake(_edgeinsets.left+_miniteritemsspacing*(indexPath.item/shu)+self.myitemsize.width*(indexPath.item/shu),_edgeinsets.top+offsety*(indexPath.item%shu) +self.myitemsize.height*(indexPath.item%shu), self.myitemsize.width, self.myitemsize.height);

        }
        else{
            attr.frame =CGRectMake(_edgeinsets.left+_miniteritemsspacing*(indexPath.item/shu)+self.myitemsize.width*(indexPath.item/shu),(self.motherSize.height-_myitemsize.height)/2, self.myitemsize.width, self.myitemsize.height);

        }
//                MYLog(@"...%g  %g",attr.frame.origin.x,attr.frame.origin.y);
    }
    else{
        
        //算出item间隔
        CGFloat offsetx;
        if (heng>1) {
            offsetx =(_motherSize.width-_edgeinsets.left-_edgeinsets.right-heng*_myitemsize.width)/(heng-1);
             attr.frame =CGRectMake(_edgeinsets.left+offsetx*(indexPath.item%heng)+self.myitemsize.width*(indexPath.item%heng), _edgeinsets.top+_minlinespacing*(indexPath.item/heng)+self.myitemsize.height*(indexPath.item/heng), self.myitemsize.width, self.myitemsize.height);
        }else{
            attr.frame =CGRectMake((_motherSize.width-_myitemsize.width)/2 ,_edgeinsets.top+_minlinespacing*(indexPath.item/heng)+self.myitemsize.height*(indexPath.item/heng), self.myitemsize.width, self.myitemsize.height);
        }

       

       
    
    }
    return attr;
}

-(CGSize)collectionViewContentSize{
    CGFloat wlong =MAX([[self.attriarry lastObject] frame].origin.x+self.myitemsize.width,_myitemsize.width);
   
    CGFloat hlong = MAX([[self.attriarry lastObject] frame].origin.y+self.myitemsize.height+_edgeinsets.bottom,_myitemsize.height+_edgeinsets.bottom);
   
    if (self.isHorizontal) {
        return CGSizeMake(wlong, hlong);
    }else{
        return CGSizeMake(wlong, hlong);
    }
    
}


@end
