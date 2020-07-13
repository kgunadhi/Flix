//
//  MovieAPIManager.m
//  Flix
//
//  Created by Kaitlyn Gunadhi on 7/1/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MovieAPIManager.h"
#import "Movie.h"

@interface MovieAPIManager()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation MovieAPIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    return self;
}

- (void)fetchNowPlaying:(void(^)(NSArray *movies, NSError *error))completion {
    NSURL *const url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key="];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"results"];
            NSArray *movies = [Movie moviesWithDictionaries:dictionaries];
            
            completion(movies, nil);
        }
    }];
    [task resume];
}

@end
