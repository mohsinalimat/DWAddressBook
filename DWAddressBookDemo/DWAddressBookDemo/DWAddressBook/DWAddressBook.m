//
//  DWAddressBook.m
//  DWAddressBookDemo
//
//  Created by dwang_sui on 2017/7/28.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import "DWAddressBook.h"
#import "DWContactController.h"
#import "PPGetAddressBook.h"

@interface DWAddressBook ()
@property(nonatomic, strong) DWContactController *contactController;
@property(nonatomic, copy) NSString *auth;
@end

@implementation DWAddressBook

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
}

+ (void)requestAddressBookAuthorization {
    [PPGetAddressBook requestAddressBookAuthorization];
}

- (instancetype)initWithControllerTitle:(NSString *)title resultBlock:(void(^)(NSString *name, NSString *mobNumber))resultBlock failure:(void(^)())failure {
    _contactController = [[DWContactController alloc] init];
    _contactController.title = title;
    self = [super initWithRootViewController:_contactController];
    _contactController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClick)];
    __weak __typeof(self)weakSelf = self;
        [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
            _contactController.cellModelDict = addressBookDict;
            _contactController.cellModelKeysArr = nameKeys;
            [_contactController.tableView reloadData];
        } authorizationFailure:^{
            failure();
            [_contactController.navigationController setNavigationBarHidden:YES animated:YES];
            _contactController.navigationController.view.backgroundColor = [UIColor clearColor];
            _contactController.view.backgroundColor = [UIColor clearColor];
            [weakSelf cancelButtonClick];
        }];
    return self;
}

- (void)cancelButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setCancelBtnTitle:(NSString *)cancelBtnTitle {
    _cancelBtnTitle = cancelBtnTitle;
    _contactController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:cancelBtnTitle style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonClick)];
}

- (void)setNaviTitleFont:(UIFont *)naviTitleFont {
    _naviTitleFont = naviTitleFont;
    [self configNaviTitleAppearance];
}

- (void)setNaviTitleColor:(UIColor *)naviTitleColor {
    _naviTitleColor = naviTitleColor;
    [self configNaviTitleAppearance];
}

- (void)setNaviBgColor:(UIColor *)naviBgColor {
    _naviBgColor = naviBgColor;
    self.navigationBar.barTintColor = naviBgColor;
}

- (void)configNaviTitleAppearance {
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = self.naviTitleColor;
    textAttrs[NSFontAttributeName] = self.naviTitleFont;
    self.navigationBar.titleTextAttributes = textAttrs;
}

- (void)setCancelBtnFont:(UIFont *)cancelBtnFont {
    _cancelBtnFont = cancelBtnFont;
    [self configBarButtonItemAppearance];
}

- (void)setCancelBtnColor:(UIColor *)cancelBtnColor {
    _cancelBtnColor = cancelBtnColor;
    [self configBarButtonItemAppearance];
}

- (void)configBarButtonItemAppearance {
    UIBarButtonItem *barItem;
    if (iOS9Later) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[DWAddressBook class]]];
    } else {
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[DWAddressBook class], nil];
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = self.cancelBtnColor;
    textAttrs[NSFontAttributeName] = self.cancelBtnFont;
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)setShowTotalNumber:(BOOL)showTotalNumber {
    _contactController.showTotalNumber = showTotalNumber;
}

- (void)setIndexBGColor:(UIColor *)indexBGColor {
    _contactController.tableView.sectionIndexBackgroundColor = indexBGColor;
}

- (void)setIndexColor:(UIColor *)indexColor {
    _contactController.tableView.sectionIndexColor = indexColor;
}

@end
