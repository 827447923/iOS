//
//  AddProductViewController.m
//  Shop
//
//  Created by 陈立豪 on 16/8/5.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "AddProductViewController.h"

@interface AddProductViewController () <UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *describeTextView;


@property (weak,nonatomic) UITextField *activeTextField;
@property (weak,nonatomic) UITextView  *activeTextView;
@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"添加商品";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    for (int i=1; i<=8; i++) {
        UITextField *textField = (UITextField*)[self.view viewWithTag:i];
        textField.delegate = self;
    }
    _describeTextView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 处理键盘事件

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

//textView 按下回车时取消键盘
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (IBAction)backgroundTap:(id)sender {
    if(_activeTextField != nil){
        [_activeTextField resignFirstResponder];
    }else if(_activeTextView != nil){
        [_activeTextView resignFirstResponder];
    }
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //记录已经激活的TextView
    _activeTextField = textField;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _activeTextView = textView;
    return YES;
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeTextField = nil;
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _activeTextView = nil;
}

// keyboard出现，发出通知

-(void)keyboardWillShow:(NSNotification*)notification
{
    CGRect frame;
    if (_activeTextField != nil) {
        frame = _activeTextField.frame;
    }else if(_activeTextView !=nil){
        frame = _activeTextView.frame;
    }else{
        return;
    }
    //获取键盘高度
    CGFloat kbHeight = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
    //计算文本框底部到键盘顶端的距离
    int offset = frame.origin.y+frame.size.height - (self.view.frame.size.height-kbHeight);
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
