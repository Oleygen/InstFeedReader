//
//  InstaAPIClient.m
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import "FeedAPIClient.h"

@implementation FeedAPIClient

#pragma mark - Public methods

-(void)fetchFeedWithSuccessBlock:(SUCCESS_BLOCK)successBlock failureBlock:(ERROR_FAILURE_BLOCK)failureBlock {
    NSMutableArray<NSString *> *temp = [NSMutableArray array];
    for (int i = 1; i <=6; i++) {
        [temp addObject:[self jsonWithFileName:[NSString stringWithFormat:@"document%i",i]]];
    }
    if (successBlock) {
        successBlock([temp copy]);
    }
}

#pragma mark - Private methods

-(NSString *)jsonWithFileName:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSString *json = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    return json;
}

@end
