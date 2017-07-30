//
//  ViewController.m
//  DWAddressBookDemo
//
//  Created by dwang_sui on 2017/7/28.
//  Copyright © 2017年 dwang. All rights reserved.
//

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#import "ViewController.h"
#import "DWAddressBook.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end



@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [DWAddressBook requestAddressBookAuthorization];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DWAddressBook *addressbook = [[DWAddressBook alloc] initWithResultBlock:^(NSString *name, NSString *mobNumber) {
    self.label.text = [NSString stringWithFormat:@"%@\n%@", name, mobNumber];
    } failure:^{
        NSLog(@"授权失败");
    }];
    addressbook.naviTitle = @"活动圈";
    addressbook.naviTitleColor = [UIColor orangeColor];
    addressbook.naviTitleFont = [UIFont systemFontOfSize:33];
    addressbook.naviBgColor = [UIColor blueColor];
    addressbook.cancelBtnColor = [UIColor orangeColor];
    addressbook.cancelBtnFont = [UIFont systemFontOfSize:22];
    addressbook.showTotalNumber = YES;
//    addressbook.cancelBtnTitle = @"确定";
    addressbook.indexBGColor = [UIColor orangeColor];
    addressbook.indexColor = [UIColor blackColor];
    [self presentViewController:addressbook animated:YES completion:nil];
}

@end
