//
//  AGProduct+Parse.m
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGProduct+Parse.h"

@implementation AGProduct (Parse)

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Creates a new AGProduct object by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGProduct instance
 */
+(AGProduct*)productWithJsonObject:(NSDictionary*)jsonObject{
    if ([jsonObject isEqual: [NSNull null]]){
        return nil;
    }
    
    AGProduct* product = nil;
    
    NSDictionary* productDict = [jsonObject objectForKey:@"product"];
    if (![productDict isEqual: [NSNull null]]){
        NSString* productName = [productDict valueForKey:@"name"];
        NSNumber* price = [productDict valueForKey:@"price"];
        
        if(![productName isEqual: [NSNull null]]){
            /**  Create the product object  */
            product = [[AGProduct alloc] init];
            [product setName:productName];
            
            if(![price isEqual: [NSNull null]]){
                [product setPrice:[price floatValue]];
            }
            
            [product setImageURL:[AGProduct firstProductImageWithJSONObject:productDict]];
            
        }
    }
    
    return product;
}

/**
 Retrieves the first image url string of the product, by parsing the jsonObject
 @param jsonObject An NSDictionary object with json data
 @return The new AGProduct instance
 */
+(NSString*)firstProductImageWithJSONObject:(NSDictionary*)jsonObject{
    
    NSArray* imagesArray = [jsonObject valueForKey:@"images"];
    if ([imagesArray isEqual: [NSNull null]]){
        return nil;
    }
    
    NSDictionary *imageDict = [imagesArray firstObject];
    if (imageDict != nil && ![imagesArray isEqual:[NSNull null]]){
        NSString* url = [imageDict valueForKey:@"url"];
        if (![url isEqual:[NSNull null]]){
            return url;
        }
    }
    
    return nil;
}

@end
