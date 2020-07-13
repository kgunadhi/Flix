//
//  Movie.h
//  Flix
//
//  Created by Kaitlyn Gunadhi on 7/1/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *posterUrl;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSURL *backdropUrl;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSNumber *movieId;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
