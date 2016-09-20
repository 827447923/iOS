//
//  AddProductViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/8/5.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "AddProductViewController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "Masonry.h"
#import "DB.h"
#import "DB+Product.h"
#import "StructInfo.h"
#import "Common/UIViewController+Common.h"
#import "User.h"

@interface AddProductViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) TPKeyboardAvoidingTableView *tableView;
@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"添加商品";
    self.tableView = [[TPKeyboardAvoidingTableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.tableView.estimatedRowHeight = 44.0f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(addNewProduct)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *productInfoIdentifier = @"ProductInfoIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:productInfoIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productInfoIdentifier];
    }
    
    UILabel *label = [[UILabel alloc]init];
    [cell addSubview:label];
    label.textAlignment = NSTextAlignmentRight;
    label.adjustsFontSizeToFitWidth = YES;
    label.text = [NSString stringWithFormat: @"%@:",productInfos[indexPath.row]];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScaleFrom_iPhone5_Desgin(70));
        make.left.top.equalTo(cell).offset(10);
    }];
    
    if(indexPath.row <= 7){
        UITextField *textField = [[UITextField alloc]init];
        textField.tag = 1;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [cell addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label.mas_right).offset(10);
            make.top.equalTo(cell).offset(2);
            make.bottom.right.equalTo(cell).offset(-2);
        }];
    }else if(indexPath.row == 8){
        UITextView *textView = [[UITextView alloc]init];
        textView.tag = 2;
        [cell addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label.mas_right).offset(10);
            make.right.equalTo(cell).offset(-10);
            make.height.mas_equalTo(88);
        }];
    }else if(indexPath.row == 9){
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 3;
        [cell addSubview:imageView];
        imageView.image= [UIImage imageNamed:@"jpg-200"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScaleFrom_iPhone5_Desgin(230));
            make.left.equalTo(label.mas_right).offset(10);
            make.right.equalTo(cell).offset(-10);
        }];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 8)
        return 90.0;
    else if(indexPath.row == 9)
        return kScaleFrom_iPhone5_Desgin(230);
    else
        return 44.0;
}

-(void)addNewProduct{
    NSArray *productMembers =  @[@"m_Name",@"m_NO",@"m_Number",@"m_Unit",@"m_Type",@"m_PurchasePrice",@"m_RetailPrice",@"m_WholesalePrice",@"m_Description",@"m_Image"];
    Product *product = [[Product alloc]init];
    for (NSInteger i=0; i<=9; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if(i<=7)
            [product setValue:((UITextField*)[cell viewWithTag:1]).text forKey:productMembers[i]];
        else if(i==8)
            [product setValue:((UITextView*)[cell viewWithTag:2]).text forKey:productMembers[8]];
        else if(i==9)
        {
            [self saveImage:((UIImageView*)[cell viewWithTag:3]).image withName:product.m_Name atPath:@"Product"];
            product.m_ImagePath = [NSString stringWithFormat:@"%@/product/%@.png",[User shareUser].name,product.m_Name];
        }
    }
    if([[DB shareDB] AddProduct:product]){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ProductArrayChanged" object:nil];
        for (NSInteger i=0; i<=9; i++) {
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加商品" message:@"商品已经添加成功！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            if(i<=7)
                ((UITextField*)[cell viewWithTag:1]).text = @"";
            else if (i == 8)
                ((UITextView*)[cell viewWithTag:2]).text = @"";
            else if(i==9)
                ((UIImageView*)[cell viewWithTag:3]).image = nil;
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加商品" message:@"商品添加失败，请检查填入信息是否正确！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
