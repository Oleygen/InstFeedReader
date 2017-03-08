//
//  Post.h
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Post;
typedef void(^POST_SUCCESS_BLOCK)(NSArray<Post *>*posts);

@interface Post : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *articleDescription;
@property (strong, nonatomic) NSString *imageURL;


@end
