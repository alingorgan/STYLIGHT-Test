//
//  AGResultsParser.h
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGResultsParser : NSObject

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods


/**
 Parse the new results using the specified data
 @param jsonData An NSData object which will be deserialized into a JSON top level object
 @return An array containing the parsed results
 */
-(NSArray*)resultsWithJSONData:(NSData*)jsonData;

@end
