//
//  AGResultsParser.m
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGResultsParser.h"

#import "AGBoard.h"
#import "AGBoard+Parse.h"

#import "AGProduct.h"
#import "AGProduct+Parse.h"

@implementation AGResultsParser


/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Parse the new results using the specified data
 @param jsonData An NSData object which will be deserialized into a JSON top level object
 @return An array containing the parsed results
 */
-(NSArray*)resultsWithJSONData:(NSData*)jsonData{
    
    NSError* error = nil;
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments
                                                           error:&error];
    
    if (error){
        /**  This isn't jsonData, return nil */
        return nil;
    }
    
    return [self resultsArrayWithJsonObject:root];
}


/**
 Parse the jsonObject and create the actual results
 @param jsonObject The jsonObject to parse
 @return The array of parsed objects
 */
-(NSArray*)resultsArrayWithJsonObject:(NSDictionary*)jsonObject{
    NSMutableArray* resultsArray = [NSMutableArray array];
    
    NSArray* itemArray = [jsonObject valueForKey:@"items"];
    if ([itemArray isEqual: [NSNull null]]){
        return resultsArray;
    }
    
    for (int itemIndex = 0; itemIndex < itemArray.count; itemIndex++){
        NSDictionary* itemDict = [itemArray objectAtIndex:itemIndex];
        
        if ([itemDict isEqual: [NSNull null]]){
            continue;
        }
        
        NSDictionary* boardDict = [itemDict valueForKey:@"board"];
        AGBoard* board = [AGBoard boardWithJSONObject:boardDict];
        
        AGProduct* product = [AGProduct productWithJsonObject:itemDict];
        if (product){
            [board setProductArray:[NSArray arrayWithObject:product]];
        }
        else{
            [board setProductArray:[self resultsArrayWithJsonObject:boardDict]];
        }
        
        if (board.productArray.count > 0){
            [resultsArray addObject:board];
        }
        
    }
    
    return resultsArray;
}

@end
