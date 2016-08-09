//
//  VEButtonView.m
//  VEButtonView
//
//  Created by zxw-lzq on 16/3/24.
//  Copyright © 2016年 msmeHewei. All rights reserved.
//

#import "VESelectorView.h"


@interface VESelectorView()
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)CGFloat unitWidth;
@property (nonatomic,strong)NSMutableArray *itemMutableArray;

//底部视图
@property (nonatomic,strong)UIView *bottomView;
@end


@implementation VESelectorView
{
    CGFloat currentX;
}

#pragma mark  - lazyload
- (NSMutableArray *)itemMutableArray{
    if (!_itemMutableArray) {
        _itemMutableArray = @[].mutableCopy;
    }
    return _itemMutableArray;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = [UIColor redColor];
    }
    return _bottomView;
}
#pragma mark  - init
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _count = 0;
        currentX = 0;
    }
    return self;
}
#pragma mark  - setter

#pragma mark  - dataSources
- (void)setDataSources:(id<VESelectorViewDataSources>)dataSources{
    _dataSources = dataSources;
    
    BOOL hasSetupNumbers = [self.dataSources respondsToSelector:@selector(numberOfItemInSelectorView:)];
    BOOL hasSetupSubViews = [self.dataSources respondsToSelector:@selector(selectorView:viewForItem:atIndex:)];
    
    if (hasSetupNumbers && hasSetupSubViews) {
        
        self.count = [self.dataSources numberOfItemInSelectorView:self];
        _unitWidth = self.frame.size.width / _count;
        
        for (NSInteger i = 0; i < self.count; i++) {
            UIView *itemView = [[UIView alloc]initWithFrame:CGRectMake(currentX, 0, _unitWidth, self.frame.size.height)];
            
            UIView *subview = [self.dataSources selectorView:self viewForItem:itemView atIndex:i];
            [itemView addSubview:subview];
            
            [self.itemMutableArray addObject:itemView];
            [self addSubview:itemView];
            
            currentX += _unitWidth;
        }
        
        //底部横线
        [self.bottomView setFrame:CGRectMake(0, self.bounds.size.height - 3, _unitWidth, 3)];
        [self addSubview:_bottomView];
        
        
        
    }

}
#pragma mark  - delegate
- (void)setDelegate:(id<VESelectorViewDelegate>)delegate{
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(selectorView:didSelectedItemAtIndex:)]) {
        
        for (NSInteger i = 0; i < _itemMutableArray.count; i++) {
            
            UIView *itemView = [_itemMutableArray objectAtIndex:i];
            
            UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
            [itemView addGestureRecognizer:tapGR];
            
        }
    }
}
- (void)click:(UIGestureRecognizer*)gestureRecognizer{
    
    UIView *selectView = gestureRecognizer.view;
    
    //底部视图
    CGRect bottomViewFrame = _bottomView.frame;
    bottomViewFrame.origin.x = selectView.frame.origin.x;
    [UIView animateWithDuration:0.3 animations:^{
        [_bottomView setFrame:bottomViewFrame];
    }];
    
    __block NSInteger index;
    [_itemMutableArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:selectView]) {
            index = idx;
        }
    }];
    
    [self.delegate selectorView:self didSelectedItemAtIndex:index];
}
#pragma mark  - public method
- (void)reloadData{
    
    _count = 0;
    currentX = 0;
    
    for (UIView *itemView in _itemMutableArray) {
        [itemView removeFromSuperview];
    }
    [_itemMutableArray removeAllObjects];
    
    self.dataSources = self.dataSources;
    self.delegate = self.delegate;
    
}
- (UIView *)itemForIndex:(NSInteger)index{
    UIView *itemView = [_itemMutableArray objectAtIndex:index];
    return itemView.subviews.firstObject;
}
@end
