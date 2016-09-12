//
//  ViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/7/20.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "LoginViewController.h"
#import "DB.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "Masonry.h"


extern int global_user_id;


@interface LoginViewController ()
@property (strong, nonatomic)  UILabel *nameLabel,*passwordLabel,*logoLabel;
@property (strong, nonatomic)  UITextField *nameTextField,*passwordTextField;
@property (strong, nonatomic)  UIButton *loginBtn, *registerBtn;
@property (strong, nonatomic)  TPKeyboardAvoidingScrollView *view1 ;
@property (strong,nonatomic) DB *db;


@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _db = [[DB alloc]init];
    


    self.view1 = [[TPKeyboardAvoidingScrollView alloc]init];
    
    [self.view addSubview:self.view1];
    self.view1.backgroundColor = UIColorFromRGB(0x98FB98);
    
    
    self.view1.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self configureControls];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 添加控件，并进行布局
-(void) configureControls{
    CGFloat padding = kScaleFrom_iPhone5_Desgin(10);
    CGFloat controlHeight = kScaleFrom_iPhone5_Desgin(28);
    
    
    self.logoLabel=({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"test";
        label.textAlignment = NSTextAlignmentCenter;
        label.adjustsFontSizeToFitWidth = YES;
        label.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:60];
        label;
    });
    
    self.nameLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"用户名：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });
    self.passwordLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.text = @"密码：";
        label.textAlignment = NSTextAlignmentRight;
        label;
    });

    
    
    self.passwordTextField=({
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.layer.cornerRadius = controlHeight/2;
        textField.placeholder = @"请输入密码";
        textField.clearButtonMode = YES;
        textField.secureTextEntry = YES;
        textField;
    });
    
    self.nameTextField=({
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.layer.cornerRadius = controlHeight/2;
        textField.clearButtonMode = YES;
        textField.placeholder = @"请输入用户名";
        textField;
    });
    
    //button
    UIColor *darkColor = UIColorFromRGB(0x28303b);
    CGFloat buttonWidth = kScreen_Width * 0.4;
    CGFloat buttonHeight = kScaleFrom_iPhone5_Desgin(38);
    self.loginBtn=({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:darkColor forState:UIControlStateNormal];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = darkColor.CGColor;
        button;
    });
    self.registerBtn=({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        button.backgroundColor = darkColor;
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"注册" forState:UIControlStateNormal];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = buttonHeight/2;
        button;
    });
    
    [self.view1 addSubview:self.logoLabel];
    [self.view1 addSubview:self.nameLabel];
    [self.view1 addSubview:self.passwordLabel];
    [self.view1 addSubview:self.nameTextField];
    [self.view1 addSubview:self.passwordTextField];
    [self.view1 addSubview:self.loginBtn];
    [self.view1 addSubview:self.registerBtn];
    

    [self.logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width*0.6, kScreen_Width*0.3));
        make.left.equalTo(self.view1.mas_left).offset(kScreen_Width*0.2);
        make.top.equalTo(self.view1.mas_top).offset(kScreen_Height*0.2);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width*0.2, controlHeight));
        make.left.equalTo(self.view1.mas_left).offset(padding);
        make.top.equalTo(self.view1.mas_top).offset(kScreen_Height*0.7);
    }];
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width*0.2, controlHeight));
        make.left.equalTo(self.view1.mas_left).offset(padding);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(padding);
    }];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width*0.7, controlHeight));
        make.left.equalTo(self.nameLabel.mas_right).offset(padding);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width*0.7, controlHeight));
        make.left.equalTo(self.passwordLabel.mas_right).offset(padding);
        make.centerY.equalTo(self.passwordLabel.mas_centerY);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width/2-2*padding, buttonHeight));
        make.left.equalTo(self.view1.mas_left).offset(padding);
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(10);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width/2-2*padding, buttonHeight));
        make.left.equalTo(self.loginBtn.mas_right).offset(padding*2);
        //make.right.equalTo(self.view1);
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(10);
    }];
}


#pragma mark - 按钮功能
- (void)registerBtnPressed{
    NSString *account = [_nameTextField text];
    NSString *psw = [_passwordTextField text];
    if([_db registerWithAccount:account Password:psw] !=YES){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"您的账号已注册或者格式有误，请检查。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注册成功" message:@"请用新帐号进行登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)Login{
    NSString *account = [_nameTextField text];
    NSString *psw = [_passwordTextField text];
    if([_db LoginWithAccount:account Password:psw] !=YES){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"帐号或密码有误。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else{

        UITabBarController *homeController = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
//        [UIView beginAnimations:@"View Flip" context:NULL];
//        [UIView setAnimationDuration:0.4];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        homeController.view.frame = self.view.frame;
        //需要有父对象
        //[self switchViewFromViewController:self toViewController:homeController];
        
        //需要有父对象
        //[self transitionFromViewController:self toViewController:homeController duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:nil];
        //设置动画
        homeController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //使用模态弹出方法切换控制器
        [self presentViewController:homeController animated:YES completion:nil];

       // [UIView commitAnimations];
    }
}


//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    return UIInterfaceOrientationMaskPortrait;
//}

@end
