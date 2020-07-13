//
//  MovieCollectionCell.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 6/26/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCollectionCell

- (void)setMovie:(Movie *)movie {
    // Set underlying private storage _movie since replacing default setter
    _movie = movie;
    self.posterView.image = nil;
    if (self.movie.posterUrl != nil) {
        [self.posterView setImageWithURL:self.movie.posterUrl];
    }
    self.posterView.layer.cornerRadius = 7;
}

@end
