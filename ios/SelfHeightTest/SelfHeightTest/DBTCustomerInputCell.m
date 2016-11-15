//
//  DBTCustomerInputCell.m
//  DistributionIPhone
//
//  Created by parkinwu on 2016/10/11.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import "DBTCustomerInputCell.h"

@interface DBTCustomerInputCell ()

@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeight;
@end


@implementation DBTCustomerInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.inputView.delegate = self;
//    self.contentView.translatesAutoresizingMaskIntoConstraints= NO;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {

    [self updateInputViewHeight];
    _inputText = textView.text;
    if (_delegate && [_delegate respondsToSelector:@selector(dbtCustomerInputTextDidChanged:)]) {
        [_delegate dbtCustomerInputTextDidChanged:self];
    }
}
- (void)updateInputViewHeight {
    CGRect bounds = self.inputView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [self.inputView sizeThatFits:maxSize];
    self.inputViewHeight.constant = newSize.height;
}


- (void)setInputText:(NSString *)inputText {
    _inputText = inputText;
    self.inputView.text = inputText;
    [self updateInputViewHeight];
    
}


- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    
    return (UITableView *)tableView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
