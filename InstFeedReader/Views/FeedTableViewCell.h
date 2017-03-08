//
//  FeedTableViewCell.h
//  InstFeedReader
//
//  Created by Gennadii on 3/8/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end
