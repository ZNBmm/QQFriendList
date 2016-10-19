//
//  ViewController.m
//  FriendsList
//
//  Created by hellovoidworld on 14/12/12.
//  Copyright (c) 2014年 hellovoidworld. All rights reserved.
//

#import "ViewController.h"
#import "Friend.h"
#import "FriendGroup.h"
#import "FriendCell.h"
#import "FriendHeader.h"
#import "FriendTopView.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#define ZNBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define ZNBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:a]
// 遵守FriendHeaderDelegate协议
@interface ViewController () <FriendHeaderDelegate>

@property(nonatomic, strong) NSArray *friendGroups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置headerView
    [self setupTableHeaderView];
    
    self.title = @"联系人";
    self.tableView.backgroundColor = ZNBColor(230, 230, 230);
    self.tableView.sectionHeaderHeight = 44;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 状态栏隐藏
/*
- (BOOL)prefersStatusBarHidden {
    return YES;
}
 */

/** 加载数据 */
- (NSArray *) friendGroups {
    if (nil == _friendGroups) {
        NSArray *groupsArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil]];
        
        NSMutableArray *mgroupsArray = [NSMutableArray array];
        for (NSDictionary *groupDict in groupsArray) {
            FriendGroup *group = [FriendGroup friendGroupWithDictionary:groupDict];
            [mgroupsArray addObject:group];
        }
        // 添加空数据
        [mgroupsArray insertObject:[[FriendGroup alloc] init] atIndex:0];
        [mgroupsArray insertObject:[[FriendGroup alloc] init] atIndex:3];
        self.friendGroups = mgroupsArray;
    }
    
    return _friendGroups;
}
- (void)setupTableHeaderView {
    FriendTopView *headerView = [FriendTopView shareTopView];
    headerView.frame = CGRectMake(0, 0, ScreenW, 100);
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - dataSource方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendGroups.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FriendGroup *group = self.friendGroups[section];
    // 先检查模型数据内的伸展标识
    return group.isOpened? group.friends.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendCell *cell = [FriendCell cellWithTableView:self.tableView];
    FriendGroup *group = self.friendGroups[indexPath.section];
    cell.friendData = group.friends[indexPath.row];
    return cell;
}

/** 自定义每个section的头部 */
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 22)];
        return view;
    }
    if (section == 3) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 22)];
        return view;
    }
    FriendHeader *header = [FriendHeader friendHeaderWithTableView:self.tableView];
    // 加载数据
    header.friendGroup = self.friendGroups[section];
    // 设置代理
    header.delegate = self;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 3 || section == 0) {
        return 22;
    }
    return 44;
}

#pragma mark - FriendHeaderDelegate方法
- (void)friendHeaderDidClickedHeader:(FriendHeader *)header {
    // 刷新数据
    [self.tableView reloadData];
}

@end
