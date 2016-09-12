//
//  AvodingKeyboardView.m
//  Shop
//
//  Created by 陈立豪 on 16/9/6.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "AvodingKeyboardView.h"

@interface AvodingKeyboardView()
@property (nonatomic,strong) UITextField *activeTextField;
@end



@implementation AvodingKeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    if ( !(self = [super initWithFrame:frame]) ) return nil;
    [self setup];
    return self;
}


-(void)awakeFromNib {
    [self setup];
}

-(void)setup{
    //设置view下所有的文本框对象的代理为self
    for(UIView *subview in self.subviews){
        if([subview isKindOfClass:[UITextField class]]){
            ((UITextField*)subview).delegate = self;
        }
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}



#pragma mark - 防止被键盘遮挡
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeTextField = textField;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _activeTextField = nil;
}


// keyboard出现，发出通知
-(void)keyboardWillShow:(NSNotification*)notification
{
    //获取键盘高度
    CGFloat kbHeight = [[[notification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey]CGRectValue].size.height;
    //计算文本框底部到键盘顶端的距离
    int offset = _activeTextField.frame.origin.y+_activeTextField.frame.size.height - (self.frame.size.height-kbHeight);
    //如果offset大于0，即文本框被键盘隐藏，将整个view上移
    if(offset>0){
        //获取键盘上升动画的时间
        double duration = [[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(0.0f, -offset, self.frame.size.width, self.frame.size.height);
        }];
    }
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    double duration = [[[notification userInfo]objectForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
    }];
}



@end
