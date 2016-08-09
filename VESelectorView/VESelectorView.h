//
//  VESelectorView.h
//  VESelectorView
//
//  Created by zxw-lzq on 16/3/24.
//  Copyright © 2016年 msmeHewei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VESelectorView;

@protocol VESelectorViewDataSources <NSObject>

@required

- (NSInteger)numberOfItemInSelectorView:(VESelectorView*)selectorView;
- (UIView*)selectorView:(VESelectorView*)selectorView viewForItem:(UIView*)item atIndex:(NSInteger)index;

@end
@protocol VESelectorViewDelegate <NSObject>

@optional

- (void)selectorView:(VESelectorView*)selectorView didSelectedItemAtIndex:(NSInteger)index;

@end


@interface VESelectorView : UIView

@property (nonatomic,weak)id<VESelectorViewDataSources> dataSources;
@property (nonatomic,weak)id<VESelectorViewDelegate> delegate;

- (void)reloadData;
- (UIView*)itemForIndex:(NSInteger)index;

@end
