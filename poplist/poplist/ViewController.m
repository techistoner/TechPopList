//
//  ViewController.m
//  poplist
//
//  Created by Techistoner on 15/8/28.
//  Copyright (c) 2015年 Tech. All rights reserved.
//

#import "ViewController.h"
#import "TePopList.h"

@interface ViewController ()
{
    NSInteger selected;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)showButton:(id)sender{
    TePopList *pop = [[TePopList alloc]initWithListDataSource:@[@"tag1",@"tag2",@"tag3",@"tag4",@"tag5"] withSelectedBlock:^(NSInteger select) {
        NSLog( @"%li" ,(long)select);
        selected = select;
    }];
    [pop show];
    [pop selectIndex:selected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
