//
//  MySettingTableViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/9/18.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "MySettingTableViewController.h"
#import "AppDelegate.h"
@implementation MySettingTableViewController
- (IBAction)Logout:(id)sender {
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate setupLoginViewController];
}

@end
