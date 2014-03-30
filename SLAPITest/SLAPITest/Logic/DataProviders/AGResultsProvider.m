//
//  AGResultsProvider.m
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGResultsProvider.h"

#import "NHRequest.h"
#import "NetworkHelper.h"
#import "RequestConductor.h"
#import "ResponseCart.h"
#import "RequestConductor.h"

#import "AGResultsParser.h"

@interface AGResultsProvider()

/********************************	Properties		********************************/
#pragma mark
#pragma mark Properties

@property (nonatomic) NSInteger page;
@property (nonatomic) NSRange rangeOfExpiredObjectsToRemove;

@end

@implementation AGResultsProvider

/********************************	Accessors		********************************/
#pragma mark
#pragma mark Accessors

@synthesize batchResultsSize = _batchResultsSize;

@synthesize page = _page;
@synthesize resultsArray = _resultsArray;


/********************************	Access Modifiers		********************************/
#pragma mark
#pragma mark Access Modifiers

-(NSMutableArray*)resultsArray{
    if (_resultsArray == nil){
        _resultsArray = [NSMutableArray array];
    }
    
    return _resultsArray;
}


/********************************	Initializers		********************************/
#pragma mark
#pragma mark Initializers

-(id)init{
    if (self = [super init]){
        /**  Custom initialization  */
        _page = -1;
    }
    
    return self;
}


/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Requests new results from the handler
 @param filter An AGProviderFilter object containing filter data
 @return void
 */
-(void)loadNewResultsWithFilter:(AGProviderFilter*)filter{
    
    /**  Start building the request  */
    NHRequest* request = [[NHRequest alloc] initWithBaseURL:@"http://api.stylight.com"];
    [request addPagePathWithName:@"api"];
    [request addPagePathWithName:@"new"];
    
    /**  Add params  */
    [request setParamWithName:@"gender" andValue:GenderFilterValue(filter.gender)];
    [request setParamWithName:@"initializeBoards" andValue:@"true"];
    [request setParamWithName:@"initializeRows" andValue:@"1024000"];
    [request setParamWithName:@"pageItems" andValue:[NSString stringWithFormat:@"%d", self.batchResultsSize]];
    [request setParamWithName:@"page" andValue:[NSString stringWithFormat:@"%d", ++self.page]];
    
    /**  Add the ApiKey  */
    [request.allHttpHeaderFields setValue:@"D13A5A5A0A3602477A513E02691A8458" forKeyPath:@"X-apiKey"];
    
    /**  Use expired content, if any, so we're not showing a blank screen between restarts   */
    [request setShouldInvalidateCacheOnExpiry:NO];
    
    /**  Invalidate cached requests and their data, it they're older than 15 minutes (900 seconds)  */
    [request setCacheTimeoutInterval:900];
    
    /**  Execute the request  */
    [[RequestConductor sharedConductor] performRequest:request
                                    andCompletionBlock:^void(ResponseCart** responseCart){
            
            /**  Parse the new results   */
            AGResultsParser *parser = [[AGResultsParser alloc] init];
            NSArray* newResults = [parser resultsWithJSONData:(*responseCart).responseData];

            if (self.rangeOfExpiredObjectsToRemove.length != 0){
                /**  Remove expired results which have populated the UI, previously  */
                [self.resultsArray removeObjectsInRange:self.rangeOfExpiredObjectsToRemove];
                self.rangeOfExpiredObjectsToRemove = NSMakeRange(0, 0);
            }
            
            /**  Add the new results  */
            [self.resultsArray addObjectsFromArray:newResults];
            
            /**  Let the handler know about the new data  */
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.delegate resultsProvider:self loadedNewResults:newResults];
            });
                                            
            if ((*responseCart).isExpired == YES){
                /**  We've got expired data and need to refetch  */
                [(*responseCart) setShouldFetchLatestData:YES];
                self.rangeOfExpiredObjectsToRemove = NSMakeRange(self.resultsArray.count - newResults.count, newResults.count);
                return;
            }
    }];

}

@end
