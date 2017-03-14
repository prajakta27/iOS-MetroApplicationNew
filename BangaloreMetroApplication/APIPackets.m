//
//  APIPackets.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "APIPackets.h"
@implementation Request


@synthesize url = mUrl;
@synthesize optionalData = mOptionalData;
@synthesize postData = mPostData;
@synthesize requestMethod = mRequestMethod;
@synthesize requestID = mRequestID;
@synthesize requestStatus = mRequestStatus;

-(id) init
{
    if (self = [super init])
    {
        mRequestStatus = [[RequestStatus alloc] init];
    }
    return self;
}
@end


@implementation Response

@synthesize responseData = mResponseData;

@end


@implementation RequestStatus
@synthesize requestStatus=mRequestStatus;
@synthesize requestError = mRequestError;
@synthesize statusCode=mStatusCode,statusMessage=mStatusMessage;
-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.requestStatus = REQUEST_INITIALIZED;
    }
    
    return self;
}
@end


