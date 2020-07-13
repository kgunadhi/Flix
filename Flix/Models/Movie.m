//
//  Movie.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 7/1/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    self.title = dictionary[@"title"];
    self.synopsis = dictionary[@"overview"];
    self.date = dictionary[@"release_date"];
    self.movieId = dictionary[@"id"];
    
    NSString *const baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = dictionary[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    self.posterUrl = [NSURL URLWithString:fullPosterURLString];
    
    NSString *backdropURLString = dictionary[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    self.backdropUrl = [NSURL URLWithString:fullBackdropURLString];

    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *movies = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}

@end
