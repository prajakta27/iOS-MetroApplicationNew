//
//  DataObjectFile.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "DataObjectFile.h"

@implementation DataObjectFile

static DataObjectFile *DataObjectFileObject =nil;

+(DataObjectFile*) getInstance
{
    if (DataObjectFileObject == nil) {
        
        DataObjectFileObject = [[self alloc] init];
    }
    return DataObjectFileObject;
}
-(void) handleFailureResponseWithRequest:(Request*) request withError:(NSError*)e
{
    NSLog(@"error-->>%@",e);
}

- (void)handleSuccessResponseWithRequest:(Request *)request AndResponse:(Response *)response
{
    NSDictionary *resp = nil;
    if([response.responseData isKindOfClass:[NSDictionary class]])
    {
        resp = (NSDictionary *)response.responseData;
    }
    switch (request.requestID)
    {
            case GET_SEARCHED_DATA_GET_REQUEST_ID:
            [self storeResponseForSearchGETApi:resp];
            break;
            
            case GET_SEARCHED_DATA_INFO_REQUEST_ID:
            [self storeResponseForSearchInformationGETApi:resp];
            break;
            
        default:
            break;
    }
    request.requestStatus.requestStatus = REQUEST_FINISHED;
    
}

-(void) storeResponseForSearchGETApi:(NSDictionary*)resp
{
    
    self.searchStationResultArray = [[NSMutableArray alloc]init];
    if(resp != nil)
    self.searchStationResultArray = [[[resp valueForKey:@"result"]valueForKey:@"finalResultData"]valueForKey:@"Stations_name"];
    NSLog(@"resp---->>>%@",resp);
    
}
-(void) storeResponseForSearchInformationGETApi:(NSDictionary*)resp
{
    
    self.searchStationInfoResultArray = [[NSMutableArray alloc]init];
    if(resp != nil)
    self.searchStationInfoResultArray = [[resp valueForKey:@"result"]valueForKey:@"finalResultData"];
    NSLog(@"resp---->>>%@",resp);
    
}


@end
