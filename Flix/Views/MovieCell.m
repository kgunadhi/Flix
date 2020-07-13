//
//  MovieCell.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 6/24/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)setMovie:(Movie *)movie {
    // Set underlying private storage _movie since replacing default setter
    _movie = movie;

    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.synopsis;

    self.posterView.image = nil;
    if (self.movie.posterUrl != nil) {
        [self.posterView setImageWithURL:self.movie.posterUrl];
    }
    self.posterView.layer.cornerRadius = 7;
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
    
    [self.synopsisLabel sizeToFit];
}

@end
