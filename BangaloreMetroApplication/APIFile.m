//
//  APIFile.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "APIFile.h"
#import "DataObjectFile.h"
@implementation APIFile
static APIFile *APIfileObject =nil;

//CATEGORY---------------READ
//1. Create Object of file--->>static APIFile *APIfileObject =nil;
//2. Create method for file ------->>>> + (APIFile*)getInstance


+ (APIFile*)getInstance
{
    if (APIfileObject == nil)
    APIfileObject = [[self alloc] init];
    
    return APIfileObject;
}

+ (void)callServerAPIWithRequest:(Request**)passedRequest httpMethodType:(HTTPMethodNames)httpMethodType AndDictionry:(NSDictionary*)dic AndRequestIDIdentifier:(REQUESTID)requestIDIdentifier
{
    
    NSString *url;
    switch (requestIDIdentifier)
    {
            case GET_SEARCHED_DATA_GET_REQUEST_ID:
        {
            NSString *categryStr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"stationName"]];
            url = [NSString stringWithFormat:@"http://rnbros.com/api/New_Folder/getSearchResult=%@",categryStr];
        }
            break;
            case GET_SEARCHED_DATA_INFO_REQUEST_ID:
        {
            NSString *fromStr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"fromStationName"]];
            NSString *toStr = [NSString stringWithFormat:@"%@",[dic valueForKey:@"toStationName"]];
            url = [NSString stringWithFormat:@"http://www.rnbros.com/api/New_Folder/getFromStation=%@&getToStation=%@",fromStr,toStr];
        }
            break;
            
        default:
            break;
    }
    
    //        case POST_BILLING_HISTORY_REQUEST_ID:
    //            url = [NSString stringWithFormat: POST_BILLING_HISTORY_URL,  SERVER_URL];
    //            break;
    //
    //        case GET_RECENT_TRANSACTIONS_REQUEST_ID:
    //            url = [NSString stringWithFormat: GET_RECENT_TRANSACTIONS_URL,  SERVER_URL, passingString];
    //            break;
    Request *pRequest = [[Request alloc] init];
    NSString *aRequestURL = nil;
    
    if(httpMethodType == hTTPMethodGet)
    aRequestURL = url;
    else
    aRequestURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    pRequest.url = [NSURL URLWithString:aRequestURL];
    pRequest.requestID = requestIDIdentifier;
    if(passedRequest)
    {
        *passedRequest = pRequest;
    }
    if(httpMethodType == hTTPMethodPost)
    {
        [self sendPostAPIWithURI:url requestId:requestIDIdentifier withDictionry:[dic mutableCopy] forRequest:pRequest];
    }
    
    if(httpMethodType == hTTPMethodGet)
    {
        [self sendGetAPIWithURI:url requestId:requestIDIdentifier forRequest:pRequest];
    }
    
}

+(void)sendPostAPIWithURI:(NSString*)urlString requestId:(REQUESTID)requestID withDictionry:(NSMutableDictionary*)dic forRequest:(Request*)pRequest
{
    
    
    NSString *data = [dic valueForKey:@"data"];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{
                                                   @"Accept"       : @"application/json",
                                                   @"Content-Type"  : @"application/json"
                                                   };
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [data dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"RESPONSE: %@",response);
        NSLog(@"DATA: %@",data);
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // Error Parsing JSON
                    [[DataObjectFile getInstance] handleFailureResponseWithRequest:pRequest withError:jsonError];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    Response *response = [[Response alloc]init];
                    response.responseData = jsonResponse;
                    [[DataObjectFile getInstance] handleSuccessResponseWithRequest:pRequest AndResponse:response];
                    
                    NSLog(@"resp-->>%@",jsonResponse);
                }
            }  else
            {
                //Web server is returning an error
            }
        } else {
            // Fail
            NSLog(@"error : %@", error.description);
        }
    }];
    [postDataTask resume];
}



+(void)sendGetAPIWithURI:(NSString*)urlString requestId:(REQUESTID)requestID forRequest:(Request*)pRequest
{
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"RESPONSE: %@",response);
        NSLog(@"DATA: %@",data);
        
        if (!error) {
            // Success
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSError *jsonError;
                NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (jsonError) {
                    // Error Parsing JSON
                    [[DataObjectFile getInstance] handleFailureResponseWithRequest:pRequest withError:jsonError];
                    
                } else {
                    // Success Parsing JSON
                    // Log NSDictionary response:
                    Response *response = [[Response alloc]init];
                    response.responseData = jsonResponse;
                    [[DataObjectFile getInstance] handleSuccessResponseWithRequest:pRequest AndResponse:response];
                    
                    NSLog(@"resp-->>%@",jsonResponse);
                }
            }  else
            {
                //Web server is returning an error
            }
        } else {
            // Fail
            NSLog(@"error : %@", error.description);
        }
    }] resume];
    
    
}

//+(void)sendPostAPIWithURI:(NSString*)urlString requestId:(REQUESTID)requestID withDictionary:(NSMutableDictionary*)dataDict andOptionalData:(NSObject*)optionalData  forRequest:(Request*)pRequest





@end

