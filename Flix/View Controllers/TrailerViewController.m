//
//  TrailerViewController.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 6/26/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "TrailerViewController.h"
#import "WebKit/WebKit.h"

@interface TrailerViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *trailerWebView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = [@"https://www.youtube.com/watch?v=" stringByAppendingString:self.trailerKey];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    [self.trailerWebView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
