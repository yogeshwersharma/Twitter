//
//  TweetsViewController.m
//  Twitter
//
//  Created by Yogi Sharma on 2/18/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetDetailsViewController.h"
#import "ComposeTweetViewController.h"

@interface TweetsViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (void)reloadTweets;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    NSLog(@"loading TweetsViewController");
    [super viewDidLoad];
    [self reloadTweets];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onSignOutButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweetButton)];
    self.navigationItem.title = @"Home";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view appeared: TweetsViewController");
    [self.tableView reloadData];
}

- (void)refresh {
    NSLog(@"tweets refresh called for");
    [self reloadTweets];
    NSLog(@"tweets refreshed");
    [self.refreshControl endRefreshing];
}

- (void)reloadTweets {
    [[TwitterClient getSharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        /*
        for (Tweet *tweet in tweets) {
            NSLog(@"tweet text: %@", tweet.text);
        }
         */
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetDetailsViewController *vc = [[TweetDetailsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    // [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}


- (void)onSignOutButton {
    NSLog(@"sign out button clicked");
    [User logout];
}

- (void)onNewTweetButton {
    NSLog(@"new tweet button clicked");
    ComposeTweetViewController *vc = [[ComposeTweetViewController alloc] init];
    vc.user = [User getCurrentUser];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
