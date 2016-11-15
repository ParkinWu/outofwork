//
//  TestCell.h
//  SelfHeightTest
//
//  Created by parkinwu on 2016/10/25.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestCell;
@protocol TestCellDelegate <NSObject>

- (void)testCellChanged:(TestCell *)cell;

@end
@interface TestCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (nonatomic, copy) NSString * text;

@property (nonatomic, weak) id<TestCellDelegate> delegate;
@end
