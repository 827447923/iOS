//
//  ViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/7/20.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "LoginViewController.h"
#import "DB.h"


@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong,nonatomic) DB *db;

@property (weak,nonatomic) UITextField *activeTextField;
@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _nameTextField.delegate = self;
    _passwordTextField.delegate = self;
    _db = [[DB alloc]init];
    
    //test
    _nameTextField.text = @"end";
    _passwordTextField.text = @"111";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 点击Done或者空白处隐藏键盘
- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

#pragma mark - 按钮功能
- (IBAction)registerBtnPressed:(UIButton *)sender {
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

- (IBAction)Login:(UIButton *)sender {
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

/*
-(void)switchViewFromViewController:(UIViewController*)fromVC toViewController:(UIViewController*)toVC
{
    if(fromVC != nil){
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    if(toVC != nil){
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
}
 */

#pragma mark - 防止被键盘遮挡
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //记录已经激活的TextView
    _activeTextField = textField;
    
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + frame.size.height     - (self.view.frame.size.height - 216.0-36.0);//键盘高度216或252
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    
//    [UIView commitAnimations];
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeTextField = nil;
    
//    [UIView animateWithDuration:0.3f animations:^{
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    }];
}


// keyboard出现，发出通知

-(void)keyboardWillShow:(NSNotification*)notification
{
    //获取键盘高度
    CGFloat kbHeight = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
    //计算文本框底部到键盘顶端的距离
    int offset = _activeTextField.frame.origin.y+_activeTextField.frame.size.height - (self.view.frame.size.height-kbHeight);
    //如果offset大于0，即文本框被键盘隐藏，将整个view上移
    if(offset>0){
        //获取键盘上升动画的时间
    double duration = [[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }];
    }
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    double duration = [[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

@end
