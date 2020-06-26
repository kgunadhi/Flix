//
//  DetailsViewController.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 6/25/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DetailsViewController.h"
#import "TrailerViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (nonatomic, strong) NSString *key;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    if (![backdropURLString isEqual:[NSNull null]]) {
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL:backdropURL];
    }
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
}

- (IBAction)onPosterTap:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"trailerSegue" sender:sender];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSNumber *movieId = self.movie[@"id"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",  @"https://api.themoviedb.org/3/movie/", movieId,
                                    @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               
               UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message:@"The Internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
               UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
               [networkAlert addAction:cancelAction];
               [self presentViewController:networkAlert
                                  animated:YES completion:^{}];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSArray *videos = dataDictionary[@"results"];
               for (NSDictionary *video in videos) {
                   if ([video[@"type"] isEqualToString:@"Trailer"]) {
                       self.key = video[@"key"];
                       TrailerViewController *trailerViewController = [segue destinationViewController];
                       trailerViewController.trailerKey = self.key;
                       break;
                   }
               }
           }
        }];
    [task resume];
}

@end
