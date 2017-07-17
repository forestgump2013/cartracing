//
//  RespairItemCell.m
//  234
//
//  Created by l on 8/6/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "RespairItemCell.h"
#import "RespairSubItemCell.h"
#import "RespairSubItem.h"

@implementation RespairItemCell
@synthesize subItems;
@synthesize subItemsTable;
@synthesize miles;
@synthesize cost;
@synthesize date;

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
} */

-(id) initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        NSArray *arrayOfViews=[[NSBundle mainBundle] loadNibNamed:@"RespairItemCell" owner:self options:nil];
        if ([arrayOfViews count] <1) {
            return nil;
        }
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]] ) {
            return nil;
        }
        
        self=[arrayOfViews objectAtIndex:0];
    }
    return self;
}

# pragma mark table method.

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RespairSubItemCell *subItemCell;//=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"RespairSubItemCell" owner:self options:nil];
    subItemCell=[nib objectAtIndex:0];
    NSInteger row=[indexPath row];
    RespairSubItem *subItem=[subItems objectAtIndex:row];
    //     NSLog(@"maintain record: %@ %d",record.itemname,record.lifeMiles);
    
    subItemCell.name.text=subItem.name;
    [subItemCell.cost1 setText:[[NSString alloc] initWithFormat:@"%.1f",subItem.cost1]];
    [subItemCell.cost2 setText:[[NSString alloc] initWithFormat:@"%.1f",subItem.cost2]];    
    return subItemCell;                
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subItems count];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}



@end
