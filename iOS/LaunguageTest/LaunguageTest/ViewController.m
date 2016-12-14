//
//  ViewController.m
//  LaunguageTest
//
//  Created by parkinwu on 2016/11/28.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.testLabel.text = NSLocalizedString(@"text", @"");
    
    
    // 切换语言前
    NSArray *langArr1 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language1 = langArr1.firstObject;
    NSLog(@"模拟器语言切换之前：%@",language1);
    
    NSString * before = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    NSLog(@"系统 = %@", before);
    
    // 切换语言
    NSArray *lans = @[@"ja"];
    [[NSUserDefaults standardUserDefaults] setObject:lans forKey:@"AppleLanguages"];
    while (![[NSUserDefaults standardUserDefaults] synchronize]) {
        
    }
    
    // 切换语言后
    NSArray *langArr2 = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *language2 = langArr2.firstObject;
    NSLog(@"模拟器语言切换之后：%@",language2);
    
    // 切换语言
    self.testLabel.text = NSLocalizedString(@"text", @"");
    self.view.window.rootViewController = self.view.window.rootViewController;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 切换语言
    self.testLabel.text = NSLocalizedString(@"text", @"");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
