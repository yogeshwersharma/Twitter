//
//  User.m
//  Twitter
//
//  Created by Yogi Sharma on 2/18/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.dictionary = dict;
        self.name = dict[@"name"];
        self.screenName = dict[@"screen_name"];
        self.profileImageUrl = dict[@"profile_image_url"];
        self.tagline = dict[@"description"];
    }
    return self;
}

static User *_currentUser = nil;
NSString *const kCurrentUserKey = @"kCurrentUserKey";

+ (User *)getCurrentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            _currentUser = [[User alloc] initWithDictionary:dict];
        }
    }
    return _currentUser;
}

+ (void)setCurrentUser:(User *)user {
    _currentUser = user;
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:user.dictionary options:0 error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)logout {
    [User setCurrentUser:nil];
    [[TwitterClient getSharedInstance].requestSerializer removeAccessToken];
    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end
