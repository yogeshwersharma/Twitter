//
//  LoginViewController.m
//  Twitter
//
//  Created by Yogi Sharma on 2/17/15.
//  Copyright (c) 2015 Yogi Sharma. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"

@interface LoginViewController ()
- (IBAction)onLoginButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *loginButton;

@end

@implementation LoginViewController

- (IBAction)onLoginButton:(id)sender {
    [[TwitterClient getSharedInstance]loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // Present the user.
            NSLog(@"successful login for %@", user.name);
            [self.loginButton setTintColor:[UIColor blackColor]];
            [self presentViewController:[[UINavigationController alloc] initWithRootViewController:[[TweetsViewController alloc] init]] animated:YES completion:nil];
        } else {
            // Present error view.
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
