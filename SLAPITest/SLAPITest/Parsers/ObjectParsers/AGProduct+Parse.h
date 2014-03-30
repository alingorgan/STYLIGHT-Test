//
//  AGProduct+Parse.h
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGProduct.h"

@interface AGProduct (Parse)

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Creates a new AGProduct object by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGProduct instance
 */
+(AGProduct*)productWithJsonObject:(NSDictionary*)jsonObject;


/**
 Retrieves the first image url string of the product, by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGProduct instance
 */
+(NSString*)firstProductImageWithJSONObject:(NSDictionary*)jsonObject;

@end
