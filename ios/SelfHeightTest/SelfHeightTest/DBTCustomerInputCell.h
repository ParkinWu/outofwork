//
//  DBTCustomerInputCell.h
//  DistributionIPhone
//
//  Created by parkinwu on 2016/10/11.
//  Copyright © 2016年 parkinwu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBTCustomerInputCell;
@protocol DBTCustomerInputCellDelegate <NSObject>

- (void)dbtCustomerInputTextDidChanged:(DBTCustomerInputCell *)cell;

@end

@interface DBTCustomerInputCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *inputTitleLabel;
@property (nonatomic, copy) NSString * inputText;
@property (nonatomic, copy) NSString * placeholder;
@property (nonatomic, assign) BOOL hiddenPlaceHolder;
@property (nonatomic, weak) id<DBTCustomerInputCellDelegate> delegate;
@end
