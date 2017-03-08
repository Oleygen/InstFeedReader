//
//  Constants.h
//  InstFeedReader
//
//  Created by Gennadii on 3/5/17.
//  Copyright © 2017 Gennady Oleynik. All rights reserved.
//

typedef void(^SUCCESS_BLOCK)(NSArray *data);
typedef void(^ERROR_FAILURE_BLOCK)(NSError *error);
typedef void(^DESCRIPTION_FAILURE_BLOCK)(NSString *errorDescription);

static NSString *const APIKey = @"3ec3382b0c6c4175bb67675f75277091";
static NSString *const ClientID = @"nnbvwve5w2te255htp3nsbwj";
static NSString *const RedirectURI = @"https://www.instagram.com";
static NSString *const ClientSecret = @"qEnnHTmSPkWJc78hkUmQy3nUX5heEyPPZASVzjZKS3yJy";

