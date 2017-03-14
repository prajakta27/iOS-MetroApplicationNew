//
//  DataObjectFile.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIPackets.h"
#import "ConstantsFile.h"

@interface DataObjectFile : NSObject
+(DataObjectFile*) getInstance;
- (void)handleSuccessResponseWithRequest:(Request *)request AndResponse:(Response *)response;
-(void) handleFailureResponseWithRequest:(Request*) request withError:(NSError*)e;
-(void) storeResponseForSearchGETApi:(NSDictionary*)resp;
-(void) storeResponseForSearchInformationGETApi:(NSDictionary*)resp;

@property (nonatomic, strong) NSMutableArray *searchStationResultArray;
@property (nonatomic, strong) NSMutableArray *searchStationInfoResultArray;
@property (nonatomic, assign) BOOL isFromDetailView;

@end
