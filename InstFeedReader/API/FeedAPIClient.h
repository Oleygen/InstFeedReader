//
//  InstaAPIClient.h
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface FeedAPIClient : NSObject

-(void)fetchFeedWithSuccessBlock:(SUCCESS_BLOCK)successBlock failureBlock:(ERROR_FAILURE_BLOCK)failureBlock;

@end
