//
//  TweetCell.m
//  Twitter
//
//  Created by Yogi Sharma on 2/21/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [self.userImage setImageWithURL:[NSURL URLWithString:self.tweet.profileImageUrl]];
    self.tweetTextLabel.text = self.tweet.text;
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.timeLabel.text = [self relativeDateStringForDate:self.tweet.createdAt];
    self.tweetLabel.text = self.tweet.text;
}

- (NSString *)relativeDateStringForDate:(NSDate *)date {
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;

    NSDateComponents *components = [[NSCalendar currentCalendar] components:units fromDate:date toDate:[NSDate date] options:0];
    
    if (components.year > 0) {
        return [NSString stringWithFormat:@"%ld years", (long)components.year];
    } else if (components.month > 0) {
        return [NSString stringWithFormat:@"%ld months", (long)components.month];
    } else if (components.weekOfYear > 0) {
        return [NSString stringWithFormat:@"%ldw", (long)components.weekOfYear];
    } else if (components.day > 0) {
        return [NSString stringWithFormat:@"%ldd", (long)components.day];
    } else if (components.hour > 0) {
        return [NSString stringWithFormat:@"%ldh", (long)components.hour];
    } else if (components.minute > 0) {
        return [NSString stringWithFormat:@"%ldm", (long)components.minute];
    } else {
        return @"Now";
    }
}

@end
