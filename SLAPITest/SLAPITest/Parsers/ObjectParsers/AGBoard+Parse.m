//
//  AGBoard+Parse.m
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGBoard+Parse.h"

@implementation AGBoard (Parse)

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Creates a new AGBoard object by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGBoard instance
 */
+(AGBoard*)boardWithJSONObject:(NSDictionary*)jsonObject{
    
    AGBoard* board = [[AGBoard alloc] init];
    
    if ([jsonObject isEqual: [NSNull null]]){
        return board;
    }
    
    NSDictionary* creatorDict = [jsonObject valueForKey:@"creator"];
    if (![creatorDict isEqual: [NSNull null]]){
        [board setCreatorUserName:[creatorDict valueForKey:@"username"]];
    }
    
    return board;
}

@end
