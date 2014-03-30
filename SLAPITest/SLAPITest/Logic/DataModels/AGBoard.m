//
//  AGBoard.m
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGBoard.h"

@implementation AGBoard

/********************************	Accessors		********************************/
#pragma mark
#pragma mark Accessors

@synthesize productArray = _productArray;


/********************************	Access Modifiers		********************************/
#pragma mark
#pragma mark Access Modifiers

-(NSArray*)productArray{
    if (_productArray == nil){
        _productArray = [NSArray array];
    }
    
    return _productArray;
}

@end
