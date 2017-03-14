//
//  ConstantsFile.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//


#ifndef ConstantsFile_h
#define ConstantsFile_h

typedef enum
{
    GET_SEARCHED_DATA_GET_REQUEST_ID,
    GET_SEARCHED_DATA_INFO_REQUEST_ID,
    
}REQUESTID;

typedef enum
{
    hTTPMethodGet,
    hTTPMethodPost,
    hTTPMethodPut,
    hTTPMethodDelete,
    
} HTTPMethodNames;

#define KEY_PATH_REQUEST_STATUS @"requestStatus"




#endif /* ConstantsFile_h */
