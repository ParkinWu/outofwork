//
//  TestViewController.m
//  LaunguageTest
//
//  Created by parkinwu on 2016/11/28.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testLabel.text = NSLocalizedString(@"text", @"");
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

@end
