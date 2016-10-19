//
//  FriendButton.m
//  FriendsList
//
//  Created by mac on 16/10/19.
//  Copyright © 2016年 hellovoidworld. All rights reserved.
//

#import "FriendButton.h"
#import "UIView+Frame.h"
@implementation FriendButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.znb_centerX = self.znb_width * 0.5;
    self.imageView.znb_y = 5;
    
    [self.titleLabel sizeToFit];
    
    // 设置中心点
    self.titleLabel.znb_centerX = self.znb_width * 0.5;
    self.titleLabel.znb_y = self.znb_height - self.titleLabel.znb_height;
}

@end
