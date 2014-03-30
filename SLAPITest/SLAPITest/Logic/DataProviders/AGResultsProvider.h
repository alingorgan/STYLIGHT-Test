//
//  AGResultsProvider.h
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGProviderFilter.h"

@protocol AGResultsProviderDelegate;

@interface AGResultsProvider : NSObject

/********************************	Properties		********************************/
#pragma mark
#pragma mark Properties

@property (nonatomic, weak) id<AGResultsProviderDelegate> delegate;
@property (nonatomic, strong) NSMutableArray* resultsArray;

@property (nonatomic) NSInteger batchResultsSize;

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Requests new results from the handler
 @param filter An AGProviderFilter object containing filter data
 @return void
 */
-(void)loadNewResultsWithFilter:(AGProviderFilter*)filter;

@end


/********************************	AGResultsProviderDelegate Protocol		********************************/
#pragma mark
#pragma mark AGResultsProviderDelegate Protocol

@protocol AGResultsProviderDelegate <NSObject>

@required

/**
 Notifies the handler about the retrieval of results
 @param newResults An array of the new results, just retrieved
 @return void
 */
-(void)resultsProvider:(AGResultsProvider*)provider loadedNewResults:(NSArray*)newResults;

@end
