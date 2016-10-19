//
//  FriendTopView.m
//  FriendsList
//
//  Created by mac on 16/10/19.
//  Copyright © 2016年 hellovoidworld. All rights reserved.
//

#import "FriendTopView.h"
#import "FriendButton.h"

@implementation FriendTopView

+ (instancetype)shareTopView {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
