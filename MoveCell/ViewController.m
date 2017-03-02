//
//  ViewController.m
//  MoveCell
//
//  Created by LZF on 2017/3/2.
//  Copyright © 2017年 zf.com. All rights reserved.
//

#import "ViewController.h"
#import "ZFTableView.h"

@interface ViewController ()<ZFMovableCellTableViewDelegate,ZFTableViewDataSource>
@property (nonatomic , strong) NSMutableArray * dataSource;
@property (nonatomic , strong) ZFTableView * myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataSource = @[].mutableCopy;
    
    for (NSInteger section = 0; section < 6; section ++) {
        NSMutableArray *sectionArray = [NSMutableArray new];
        for (NSInteger row = 0; row < 5; row ++) {
            [sectionArray addObject:[NSString stringWithFormat:@"第%ld区，第%ld行", section, row]];
        }
        [_dataSource addObject:sectionArray];
    }
    
    _myTableView = [[ZFTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    
    _myTableView.gestureMinimumPressDuration = 1.0;
    _myTableView.drawMovalbeCellBlock = ^(UIView *movableCell){
        movableCell.layer.shadowColor = [UIColor grayColor].CGColor;
        movableCell.layer.masksToBounds = NO;
        movableCell.layer.cornerRadius = 0;
        movableCell.layer.shadowOffset = CGSizeMake(-5, 0);
        movableCell.layer.shadowOpacity = 0.4;
        movableCell.layer.shadowRadius = 5;
    };

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    return cell;
}


#pragma mark -- ZFMovableCellTableViewDelegate,ZFTableViewDataSource

- (NSArray *)dataSourceArrayInTableView:(ZFTableView *)tableView
{
    return _dataSource.copy;
}

- (void)tableView:(ZFTableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray
{
    _dataSource = newDataSourceArray.mutableCopy;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
