//
//  XYMoreOperationView.m
//  Tang
//
//  Created by jingjing on 16/4/1.
//  Copyright © 2016年 Aaron Yu. All rights reserved.
//

#import "XYMoreOperationView.h"

@implementation XYMoreOperationView
{
//    UITableView *operationTableView;
    
    NSMutableArray *operationTitles;
    NSMutableArray *operationImages;
    
    int Tkind;
}
@synthesize operBlock, operationTableView;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
//        [self createView];
    }
    return self;
}

-(void)getTitles:(NSArray *)titles andImages:(NSArray *)images tableKind:(int)kind
{
    
    operationTitles = [titles mutableCopy];
    operationImages = [images mutableCopy];
    Tkind = kind;

    [self createView];
}

-(void)changeTitlesWithNewTitles:(NSArray *)titles
{
    operationTitles = [titles mutableCopy];
    [operationTableView reloadData];
}

-(void)createView
{
    UIImageView *backgroundImageView;
    if(Tkind == 2)
    {
        UIImage *photoImg = [UIImage imageNamed:@"operation_background"];
        photoImg = [photoImg resizableImageWithCapInsets:UIEdgeInsetsMake(20, 40, 10, 5)];
        
        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        backgroundImageView.image = photoImg;
        backgroundImageView.userInteractionEnabled = YES;
        [self addSubview:backgroundImageView];
        
        operationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*SCREEN_SCALE, self.frame.size.width, self.frame.size.height-10*SCREEN_SCALE) style:UITableViewStylePlain];
    }
    else
    {
        operationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    }
    
    operationTableView.delegate = self;
    operationTableView.dataSource = self;
    operationTableView.scrollEnabled = NO;
    operationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    operationTableView.backgroundColor = [UIColor clearColor];
    if(Tkind == 2)
    {
        [backgroundImageView addSubview:operationTableView];
        operationTableView.scrollEnabled = YES;
    }
    else
    {
        [self addSubview:operationTableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return operationTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(Tkind == 2)
    {
        return 28.0*SCREEN_SCALE;
    }
    return Cellheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [operationTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 25, 25)];
        image.tag = 101;
        [cell addSubview:image];
        
        UILabel *label = nil;
        if(operationImages.count == 0)
        {
            cell.backgroundColor = [UIColor clearColor];
            label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithHexString:@"#f66d96"];
            label = [[UILabel alloc] initWithFrame:CGRectMake(image.frame.size.width+image.frame.origin.x+8, 15, cell.frame.size.width-image.frame.size.width-image.frame.origin.x, 20)];
            label.textColor = [UIColor whiteColor];
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, Cellheight, cell.frame.size.width, 1)];
            line.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
            [cell addSubview:line];
        }
        
        label.tag = 102;
        
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
        

    }
    if(operationImages.count != 0)
    {
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [operationImages objectAtIndex:indexPath.row]]]];
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:102];
    [label setText:[operationTitles objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.operBlock(indexPath.row);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMoreOperationView *cell = (XYMoreOperationView *)[tableView cellForRowAtIndexPath:indexPath];

    UILabel *label = (UILabel *)[cell viewWithTag:102];
    label.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];

    cell.backgroundColor = [[UIColor colorWithHexString:@"#f66d96"] colorWithAlphaComponent:0.8];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    XYMoreOperationView *cell = (XYMoreOperationView *)[tableView cellForRowAtIndexPath:indexPath];

    if(Tkind == 2)
    {
        cell.backgroundColor = [UIColor clearColor];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"#f66d96"];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:102];
    label.textColor = [UIColor whiteColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
