//
//  User.h
//  Twitter
//
//  Created by Yogi Sharma on 2/18/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (User *)getCurrentUser;
+ (void)setCurrentUser:(User *)user;

+ (void)logout;
@end
