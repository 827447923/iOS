//
//  ProductNavController.m
//  Shop
//
//  Created by 陈立豪 on 16/8/3.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "ProductTableViewController.h"


static NSString *productCellIdentifier = @"ProductCellIdentifier";
static NSString *operateProductCellIdentifier = @"OprateProductCellIdentifier";
@implementation ProductTableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"test";
    self.tableView.estimatedRowHeight = 44.0;
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:operateProductCellIdentifier forIndexPath:indexPath];
        NSArray *strings = @[@"添加商品",@"修改商品"];
        cell.textLabel.text = strings[indexPath.row];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier forIndexPath:indexPath];
        //cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
        cell.textLabel.text = @"";
        return cell;
    }
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section==0?@"操作商品":@"商品列表";
}
@end
