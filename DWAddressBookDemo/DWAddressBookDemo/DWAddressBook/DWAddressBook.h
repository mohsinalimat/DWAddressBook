//
//  DWAddressBook.h
//  DWAddressBookDemo
//
//  Created by dwang_sui on 2017/7/28.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

@interface DWAddressBook : UINavigationController

/** 标题颜色 */
@property(nonatomic, strong) UIColor *naviTitleColor;

/** 标题Font */
@property(nonatomic, strong) UIFont *naviTitleFont;

/** 导航栏背景色 */
@property(nonatomic, copy) UIColor *naviBgColor;

/** 取消按钮文字 */
@property(nonatomic, copy) NSString *cancelBtnTitle;

/** 取消按钮颜色 */
@property (nonatomic, strong) UIColor *cancelBtnColor;

/** 取消Font */
@property(nonatomic, strong) UIFont *cancelBtnFont;

/** 是否显示联系人总和/在最后一行cell中显示 */
@property(nonatomic, assign) BOOL showTotalNumber;

/** 索引背景颜色 */
@property(nonatomic, strong) UIColor *indexBGColor;

/** 索引颜色 */
@property(nonatomic, strong) UIColor *indexColor;

/** 请求权限 */
+ (void)requestAddressBookAuthorization;

/**
 初始化
 @param title 标题
 @param azSort 是否使用A～Z排序方式
 @return self
 */
- (instancetype)initWithControllerTitle:(NSString *)title azSort:(BOOL)azSort resultBlock:(void(^)(NSString *name, NSString *mobNumber))resultBlock failure:(void(^)())failure;

@end
