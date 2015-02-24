//
//  Tweet.m
//  Twitter
//
//  Created by Yogi Sharma on 2/18/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        // NSLog(@"making tweet with this dictionary: %@", dict);
        self.user = [[User alloc] initWithDictionary:dict[@"user"]];
        self.text = dict[@"text"];
        NSString *createdAtString = dict[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.profileImageUrl = [dict valueForKeyPath:@"user.profile_image_url"];
    }
    return self;
}

+ (NSArray *)getTweetsFromRawDictionaries:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dict];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end
