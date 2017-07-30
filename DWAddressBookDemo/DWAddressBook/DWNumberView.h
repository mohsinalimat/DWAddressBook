//
//  DWNumberView.h
//  DWAddressBookDemo
//
//  Created by dwang_sui on 2017/7/30.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWNumberView : UITableView

/** 手机号数组 */
@property(nonatomic, strong) NSArray *numberArr;

@property(nonatomic, copy) void (^didSelectMobNumber)(NSString *number);

@end
