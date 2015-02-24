//
//  Tweet.h
//  Twitter
//
//  Created by Yogi Sharma on 2/18/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *userName;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)getTweetsFromRawDictionaries:(NSArray *)array;

@end
