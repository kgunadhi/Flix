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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *const baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    self.posterView.layer.cornerRadius = 7;
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    if (![backdropURLString isEqual:[NSNull null]]) {
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL:backdropURL];
    }
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.dateLabel.text = self.movie[@"release_date"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    [self.dateLabel sizeToFit];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    TrailerViewController *trailerViewController = [segue destinationViewController];
    trailerViewController.movieId = self.movie[@"id"];
}

@end
