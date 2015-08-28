//
//  TePopList.m
//  DSActionSheetDemo
//
//  Created by Techistoner on 15/8/27.
//  Copyright (c) 2015年 LS. All rights reserved.
//

#import "TePopList.h"
#import "TePopListCell.h"
#import <objc/runtime.h>
static NSString *poplistKey = @"poplistKey";

#define TeRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define TescreenFrame         [UIScreen mainScreen].bounds
#define TecellH       44
#define TedefauleShow      5
#define TePoplistImage(file) [@"TePoplistImage.bundle" stringByAppendingPathComponent:file]

@implementation TePopList
{
    UITableView *tableview;
    NSArray *datasource;
    UIImage *normal;
    UIImage *selected;
    NSInteger selectedIndex;
    
}
- (instancetype)initWithListDataSource:(NSArray *)source withSelectedBlock:(PopListSelectedBlock)selecteblock{
    
    
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if(self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
//        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
//        [self addGestureRecognizer:tapGestureRecognizer];
        
        normal = [UIImage imageNamed:TePoplistImage(@"RadioButton-Unselected")];
        selected = [UIImage imageNamed:TePoplistImage(@"RadioButton-Selected")];

        
        
        
        tableview = [[UITableView alloc
                      ]initWithFrame:CGRectMake(0, 0, 0,0) style:UITableViewStylePlain];
        [tableview setDataSource:self];
        [tableview setDelegate:self];
        [self addSubview:tableview];
        tableview.layer.shadowColor = [UIColor blackColor].CGColor;
        tableview.layer.shadowOffset = CGSizeMake(4,4);
        tableview.layer.shadowOpacity = 0.8;//阴影透明度，默认0
        tableview.layer.shadowRadius = 4;//阴影半径，默认3
        
        tableview.showsVerticalScrollIndicator = NO;
        tableview.tableFooterView = [[UIView alloc]init];
        datasource = [NSArray arrayWithArray:source];
        if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([tableview respondsToSelector:@selector(setLayoutMargins:)])  {
            [tableview setLayoutMargins:UIEdgeInsetsZero];
        }
        NSInteger listcount = source.count;
        if (listcount > TedefauleShow) {
            listcount = TedefauleShow;
        }
        CGSize size = CGSizeMake(200, TecellH*listcount);
        [tableview setFrame:CGRectMake(0, 0, size.height, size.width)];
        [tableview setCenter:self.center];
         self.selecteblock =selecteblock ;
    }
    
    return self;
    
}


#pragma mark tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return datasource.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TecellH;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellIdenti = @"TePopListCell";
    TePopListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdenti];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TePopListCell" owner:self options:nil] objectAtIndex:0];
    }
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor yellowColor];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    [cell.checkBtn setTag:indexPath.row];
    [cell.checkBtn addTarget:self action:@selector(checkBtnfunction:) forControlEvents:UIControlEventTouchDown];
    
    if (indexPath.row == selectedIndex) {
        [cell.checkBtn setImage:selected forState:UIControlStateNormal];
    }
    else{
        [cell.checkBtn setImage:normal forState:UIControlStateNormal];

    }
    [cell.title setText:datasource[indexPath.row]];
    return cell;
    
    
}
- (void)setSelecteblock:(PopListSelectedBlock)selecteblock {
    
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &poplistKey, selecteblock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

- (PopListSelectedBlock)selecteblock {
    
    return objc_getAssociatedObject(self, &poplistKey);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (self.selecteblock) {
        self.selecteblock(indexPath.row);
        selectedIndex = indexPath.row;
        [tableview reloadData];
        [self hide];
    }
}



-(IBAction)checkBtnfunction:(UIButton *)sender{
    

    if (self.selecteblock) {
        self.selecteblock(sender.tag);
        selectedIndex = sender.tag;
        [tableview reloadData];
        [self hide];
    }
    
    
    
}



- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];

}


- (void)hide
{
    [UIView animateWithDuration:2 animations:^{

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - Action Event
- (void)selectIndex:(NSInteger )index{
    
    if (index ) {
        selectedIndex = index;
        [tableview reloadData];
        
    }
    
    
    
}



- (void)singleTapAction:(UITapGestureRecognizer *)gestureRecognizer
{
  [self hide];
}
@end
