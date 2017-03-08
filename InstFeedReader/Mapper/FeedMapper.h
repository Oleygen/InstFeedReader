//
//  FeedMapper.h
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Post.h"

@interface FeedMapper : NSObject

-(void)fetchFeedWithSuccessBlock:(POST_SUCCESS_BLOCK)successBlock failureBlock:(ERROR_FAILURE_BLOCK)failureBlock;

@end
