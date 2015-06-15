//
//  UserNameChangeViewController.m
//  iReader20140811
//
//  Created by lcl on 13/8/14.
//  Copyright (c) 2014 lcl. All rights reserved.
//
#import "UtilityHeaders.h"
#import "UserNameChangeViewController.h"

@interface UserNameChangeViewController ()<UITextFieldDelegate>



@end

@implementation UserNameChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(didSaveNewUserName:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    [self.view addSubview:self.textField];
    self.view.backgroundColor = bgColor;
    self.navigationItem.title = @"个人信息";
}

-(UITextField*)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 100, 310, 40)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"用户名";
        _textField.font = [UIFont boldSystemFontOfSize:15.0f];
        _textField.textColor = [UIColor darkGrayColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.adjustsFontSizeToFitWidth = YES;
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.tag = 1;
        _textField.delegate = self;
    }
    return _textField;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"n"])//按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (_textField == textField)//判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 20) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:20];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"超过最大字数不能输入了"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

-(void)didSaveNewUserName:(id)sender{
    if (self.userNameChangeDelegate && [self.userNameChangeDelegate conformsToProtocol:@protocol(UserNameChangeVCDelegate)]) {
        [self.userNameChangeDelegate didChangeUserName:self withNewName:_textField.text];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
