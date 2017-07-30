//
//  DWContactController.m
//  DWAddressBookDemo
//
//  Created by dwang_sui on 2017/7/28.
//  Copyright © 2017年 dwang. All rights reserved.
//

#import "DWContactController.h"
#import "PPPersonModel.h"
#import "DWNumberView.h"

@interface DWContactController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) DWNumberView *numberView;
@end

@implementation DWContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cellModelKeysArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section!=self.cellModelKeysArr.count-1?[self.cellModelDict[self.cellModelKeysArr[section]] count]:[self.cellModelDict[self.cellModelKeysArr[section]] count]+self.showTotalNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }else {
        while ([cell.contentView.subviews lastObject]) {
            cell.detailTextLabel.text = nil;
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (indexPath.section == self.cellModelKeysArr.count-1 && indexPath.row == [self.cellModelDict[self.cellModelKeysArr[indexPath.section]] count] && self.showTotalNumber) {
        cell.userInteractionEnabled = NO;
        NSMutableArray *arrM = [NSMutableArray array];
        [self.cellModelKeysArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arrM addObject:[NSString stringWithFormat:@"%lu", [self.cellModelDict[obj] count]]];
        }];
        UILabel *all = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
        all.text = [NSString stringWithFormat:@"%@位联系人", [arrM valueForKeyPath:@"@sum.self"]];
        all.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:all];
        return cell;
    }
    PPPersonModel *people = [self.cellModelDict[self.cellModelKeysArr[indexPath.section]] objectAtIndex:indexPath.row];
    UIImageView *headerimg = [[UIImageView alloc] initWithImage:people.headerImage?people.headerImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"resources.bundle/defult@2x.png" ofType:nil]]];
    headerimg.frame = CGRectMake(15, 7.5, 45, 45);
    [cell.contentView addSubview:headerimg];
    headerimg.layer.cornerRadius = 45/2;
    headerimg.layer.masksToBounds = YES;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(headerimg.frame.size.width+30, headerimg.center.y-15, 0, 0)];
    name.text = people.name;
    name.font = [UIFont systemFontOfSize:14];
    [name sizeToFit];
    [cell.contentView addSubview:name];
    NSMutableString *str = [NSMutableString string];
    [people.mobileArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < people.mobileArray.count-1) {
            [str appendString:[NSString stringWithFormat:@"%@\n", obj]];
        }else {
            [str appendString:obj];
        }
    }];
    cell.detailTextLabel.numberOfLines = 3;
    cell.detailTextLabel.text = str;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    UILabel *az = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 25, 40)];
    az.text = self.cellModelKeysArr[section];
    az.font = [UIFont systemFontOfSize:18];
    [header addSubview:az];
    return header;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.cellModelKeysArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   PPPersonModel *people = [self.cellModelDict[self.cellModelKeysArr[indexPath.section]] objectAtIndex:indexPath.row];
    if (people.mobileArray.count > 1) {
        self.tableView.scrollEnabled = NO;
        UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:1/255 green:1/255 blue:1/255 alpha:0.4];
        
        CATransition *animation =[CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [[self.view layer]addAnimation:animation forKey:kCATransitionFade];
        [self.view addSubview:bgView];
    [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewDidClick:)]];
        _numberView = [[DWNumberView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width/3*2, people.mobileArray.count*44) style:UITableViewStylePlain];
        _numberView.numberArr = people.mobileArray;
        [self.view addSubview:_numberView];
        _numberView.center = bgView.center;
        __weak __typeof(self)weakSelf = self;
        _numberView.didSelectMobNumber = ^(NSString *number) {
            if (weakSelf.selectMobNumber) {
                weakSelf.selectMobNumber(people.name, number);
            }
        };
    }else {
        if (self.selectMobNumber) {
            self.selectMobNumber(people.name, people.mobileArray.lastObject);
        }
    }
}

- (void)bgViewDidClick:(UITapGestureRecognizer *)tap {
        self.tableView.scrollEnabled = YES;
        [_numberView removeFromSuperview];
         [tap.view removeFromSuperview];
}

- (NSArray *)cellModelKeysArr {
    if (!_cellModelKeysArr) {
        _cellModelKeysArr = [NSArray array];
    }
    return _cellModelKeysArr;
}

- (NSDictionary *)cellModelDict {
    if (!_cellModelDict) {
        _cellModelDict = [NSDictionary dictionary];
    }
    return _cellModelDict;
}

@end
