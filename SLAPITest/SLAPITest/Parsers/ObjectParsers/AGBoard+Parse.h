//
//  AGBoard+Parse.h
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGBoard.h"

@interface AGBoard (Parse)

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Creates a new AGBoard object by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGBoard instance
 */
+(AGBoard*)boardWithJSONObject:(NSDictionary*)jsonObject;

@end
