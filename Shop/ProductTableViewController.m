//
//  ProductNavController.m
//  Shop
//
//  Created by 陈立豪 on 16/8/3.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "ProductTableViewController.h"
#import "AddProductViewController.h"
#import "DB.h"
#import "DB+Product.h"
#import "ProductSumaryTableCell.h"
#import "StructInfo.h"

static NSString *productCellIdentifier = @"ProductSumaryCellIdentifier";
static NSString *operateProductCellIdentifier = @"OperateProductCellIdentifier";

@interface ProductTableViewController()

@property (strong,nonatomic) NSArray *opreationArray;
@property (strong,nonatomic) NSMutableArray *products;
@property (assign,nonatomic) BOOL hasMoreProducts;

@end
@implementation ProductTableViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"商品";
    //self.tableView.estimatedRowHeight = 44.0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddProduct)];
    
    _opreationArray = @[@"添加商品"];
    _products = [[NSMutableArray alloc]init];
    _hasMoreProducts = YES;
    
    [self firstLoadProductsWithNumber:10];
    
    //监测数据源 products是否改变
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(productArrayChanged:) name:@"ProductArrayChanged" object:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return [_opreationArray count];
    }else{
        return [_products count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:operateProductCellIdentifier forIndexPath:indexPath];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:operateProductCellIdentifier];
        }
        cell.textLabel.text = _opreationArray[indexPath.row];
        return cell;
    }else{
        [tableView registerNib:[UINib nibWithNibName:@"ProductSumaryTableCell" bundle:nil] forCellReuseIdentifier:productCellIdentifier];
        //ProductSumaryTableCell *cell;
        ProductSumaryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellIdentifier forIndexPath:indexPath];
        if(!cell){
            cell = [[ProductSumaryTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productCellIdentifier];
        }
        Product * product = [_products objectAtIndex:indexPath.row];
        cell.nameLabel.text = product.m_Name;
        cell.typeLabel.text = [NSString stringWithFormat:@"类型:%@",product.m_Type];
        cell.numberLabel.text = [NSString stringWithFormat:@"%.2f%@",product.m_Number,product.m_Unit];
        cell.retailPriceLabel.text = [NSString stringWithFormat:@"%.2f元",product.m_RetailPrice];
        cell.purchasePriceLabel.text = [NSString stringWithFormat:@"%.2f元",product.m_PurchasePrice];
        NSString *path = [[DB shareDB]dataFilePath:product.m_ImagePath];
        cell.productImageView.image = [UIImage imageWithContentsOfFile:path];
        return cell;
    }
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section==0?@"操作商品":@"商品列表";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
    }
}


//go to AddProduct Controller
-(void)AddProduct{
    [self.navigationController pushViewController:[[AddProductViewController alloc]init] animated:YES];
}

//load data first time
-(void)firstLoadProductsWithNumber:(NSInteger)num{
    [_products removeAllObjects];
    NSMutableArray *tempProducts = [[DB shareDB] QueryMoreProductsWithNumber:num FirstLoad:YES];
    if ([tempProducts count] != num) {
        _hasMoreProducts = NO;
    }
    [_products addObjectsFromArray:tempProducts];
}

//load more data
-(void)loadMoreProductsWithNumber:(NSInteger)num{
    if (!_hasMoreProducts) {
        return;
    }
    NSMutableArray *tempProducts = [[DB shareDB]QueryMoreProductsWithNumber:num FirstLoad:NO];
    [_products addObjectsFromArray:tempProducts];
}

-(void)productArrayChanged:(NSNotification*)notification{
    [self firstLoadProductsWithNumber:10];
    [self.tableView reloadData];
}

@end
