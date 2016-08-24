//
//  XYMoreOperationView.h
//  Tang
//
//  Created by jingjing on 16/4/1.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Cellheight 50.0
typedef void (^operationBlock)(NSInteger tag);

@interface XYMoreOperationView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *operationTableView;
@property (nonatomic, strong) operationBlock operBlock;

-(void)getTitles:(NSArray *)titles andImages:(NSArray *)images tableKind:(int)kind;

//点击改变文字--扩展可改变图片
-(void)changeTitlesWithNewTitles:(NSArray *)titles;

@end
