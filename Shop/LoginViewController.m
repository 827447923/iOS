//
//  ViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/7/20.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

//- (IBAction)backgroundTap:(id)sender {
//    [_nameTextField resignFirstResponder];
//    [_passwordTextField resignFirstResponder];
//}


@end
