//
//  APIFile.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConstantsFile.h"
#import "APIPackets.h"

@interface APIFile : NSObject

+ (APIFile*)getInstance;
-(void) sendHTTPGet:(NSString*)APIurl withRequestIDIdentifier:(REQUESTID)requestIDIdentifier;
+ (void)callServerAPIWithRequest:(Request**)passedRequest httpMethodType:(HTTPMethodNames)httpMethodType AndDictionry:(NSDictionary*)dic AndRequestIDIdentifier:(REQUESTID)requestIDIdentifier;





@end
