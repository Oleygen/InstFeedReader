//
//  FeedMapper.m
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import "FeedMapper.h"
#import "FeedAPIClient.h"

@interface FeedMapper()

@property (strong, nonatomic) FeedAPIClient *client;

@end
@implementation FeedMapper

static NSString *const kSource = @"source";
static NSString *const kArticles = @"articles";
static NSString *const kPublishedAt = @"publishedAt";
static NSString *const kAuthor = @"author";
static NSString *const kTitle = @"title";
static NSString *const kDescription = @"description";
static NSString *const kUrl = @"url";
static NSString *const kUrlToImage = @"urlToImage";

#pragma mark - getters & setters

-(FeedAPIClient *)client {
    if (!_client) {
        _client = [[FeedAPIClient alloc] init];
    }
    return _client;
}

#pragma mark - Public methods

-(void)fetchFeedWithSuccessBlock:(POST_SUCCESS_BLOCK)successBlock failureBlock:(ERROR_FAILURE_BLOCK)failureBlock {
    
    [self.client fetchFeedWithSuccessBlock:^(NSArray *data) {
        if (successBlock) {
            successBlock([self postsFromArray:data]);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - Private methods

-(NSArray<Post *> *)postsFromArray:(NSArray *)data {
    
    NSMutableArray<Post *> *temp = [NSMutableArray array];
    for (NSString *jsonString in data) {
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *articles = json[kArticles];
        for (NSDictionary *article in articles) {
            [temp addObject:[self postWithArticle:article]];
        }
    }
    
    return [temp copy];
}

-(Post *)postWithArticle:(NSDictionary *)article {
    Post *post = [[Post alloc] init];
    NSString *author = article[kAuthor];
    if ([author isEqual:[NSNull null]]) {
        post.author = @"No author";
    } else {
        post.author = author;
    }
    
    NSString *title = article[kTitle];
    if ([title isEqual:[NSNull null]]) {
        post.title = @"No title";
    } else {
        post.title = title;
    }
    
    NSString *articleDescription = article[kDescription];
    if ([articleDescription isEqual:[NSNull null]]) {
        post.articleDescription = @"No Description";
    } else {
        post.articleDescription = title;
    }
    
    NSString *imageURL = article[kUrlToImage];
    if ([imageURL isEqual:[NSNull null]]) {
        post.imageURL = nil;
    } else {
        post.imageURL = imageURL;
    }
    
    
    return post;
}

@end
