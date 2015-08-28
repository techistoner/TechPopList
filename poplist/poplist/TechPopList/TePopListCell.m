//
//  TePopListCell.m
//  DSActionSheetDemo
//
//  Created by Techistoner on 15/8/27.
//  Copyright (c) 2015年 LS. All rights reserved.
//

#import "TePopListCell.h"

@implementation TePopListCell

- (void)awakeFromNib {
    // Initialization code
    [self.checkBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
