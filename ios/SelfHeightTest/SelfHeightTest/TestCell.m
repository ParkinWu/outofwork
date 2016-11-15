//
//  TestCell.m
//  SelfHeightTest
//
//  Created by parkinwu on 2016/10/25.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "TestCell.h"

@implementation TestCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
    self.textView.scrollEnabled = NO;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    [self updateTextViewHeight];
    [_delegate testCellChanged:self];

}
- (void)updateTextViewHeight {
    CGRect bounds = self.textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [self.textView sizeThatFits:maxSize];
    self.textViewHeight.constant = newSize.height;
}
- (void)setText:(NSString *)text {
    _text = text;
    self.textView.text = text;
    [self updateTextViewHeight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
