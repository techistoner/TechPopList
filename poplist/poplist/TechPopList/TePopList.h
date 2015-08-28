//
//  TePopList.h
//  DSActionSheetDemo
//
//  Created by Techistoner on 15/8/27.
//  Copyright (c) 2015年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PopListSelectedBlock)(NSInteger select);

@interface TePopList : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , copy)PopListSelectedBlock selecteblock;


- (instancetype)initWithListDataSource:(NSArray *)source withSelectedBlock:(PopListSelectedBlock)selecteblock;
- (void)selectIndex:(NSInteger )index;

- (void)show;

@end
