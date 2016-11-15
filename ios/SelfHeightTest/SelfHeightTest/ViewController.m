//
//  ViewController.m
//  SelfHeightTest
//
//  Created by parkinwu on 2016/10/25.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DBTCustomerInputCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,TestCellDelegate,DBTCustomerInputCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DBTCustomerInputCell" bundle:nil] forCellReuseIdentifier:@"DBTCustomerInputCell"];
    [self.modelArray addObjectsFromArray:@[@"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉123",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉",
                                           @"爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉爱发牢骚的减肥啦手机发拉"]];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - DBTCustomerInputCellDelegate
- (void)dbtCustomerInputTextDidChanged:(DBTCustomerInputCell *)cell {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    [self.modelArray replaceObjectAtIndex:indexPath.row withObject:cell.inputText];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
#pragma mark - TestCellDelegate
- (void)testCellChanged:(TestCell *)cell {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    [self.modelArray replaceObjectAtIndex:indexPath.row withObject:cell.textView.text];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"DBTCustomerInputCell" configuration:^(DBTCustomerInputCell * cell) {
        cell.inputText = [_modelArray objectAtIndex:indexPath.row];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DBTCustomerInputCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DBTCustomerInputCell" forIndexPath:indexPath];
    cell.inputText = [_modelArray objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}
- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        self.modelArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _modelArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
