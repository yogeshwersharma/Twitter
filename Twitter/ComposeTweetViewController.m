//
//  ComposeTweetViewController.m
//  Twitter
//
//  Created by Yogi Sharma on 2/23/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "ComposeTweetViewController.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "TweetsViewController.h"
#import "Tweet.h"

@interface ComposeTweetViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userScreenName;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (strong, nonatomic) UIBarButtonItem *numCharsButton;

@end

@implementation ComposeTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTextView.delegate = self;
    
    self.numCharsButton = [[UIBarButtonItem alloc] initWithTitle:@"140" style:UIBarButtonItemStylePlain target:self action:nil];
    self.numCharsButton.tintColor = [UIColor grayColor];
    // self.numCharsButton.title = [NSString stringWithFormat:@"%lu", 140 - self.tweetTextView.text.length];
    self.numCharsButton.title = [NSString stringWithFormat:@"%lu", (unsigned long)140];
    
    
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetButton)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:tweetButton, self.numCharsButton, nil];
    
    User *user = [User getCurrentUser];
    [self.userImageView setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    self.userName.text = user.name;
    self.userScreenName.text = [NSString stringWithFormat:@"@%@", user.screenName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"editing ended: %@", self.tweetTextView.text);
}

- (void)textViewDidChange:(UITextView *)textView {
    // NSLog(@"text changed: %@", self.tweetTextView.text);
    self.numCharsButton.title = [NSString stringWithFormat:@"%lu", 140 - self.tweetTextView.text.length];
}
                                              
- (void)onTweetButton {
    NSLog(@"ready to tweet: %@", self.tweetTextView.text);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.tweetTextView.text forKey:@"status"];
    [[TwitterClient getSharedInstance] POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"successfully tweeted: %@", responseObject);
        
        NSArray *viewControllers = [self.navigationController viewControllers];
        TweetsViewController *pvc = (TweetsViewController *)[viewControllers objectAtIndex:viewControllers.count - 2];
        NSLog(@"num tweets: %lu", pvc.tweets.count);
        NSMutableArray *tweets = [NSMutableArray arrayWithArray:pvc.tweets];
        NSLog(@"old tweets: %@", tweets);
        [tweets insertObject:[[Tweet alloc] initWithDictionary:responseObject] atIndex:0];
        NSLog(@"new tweets: %@", tweets);
        pvc.tweets = tweets;
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"some failure while posting a new tweet");
    }];
}

@end
