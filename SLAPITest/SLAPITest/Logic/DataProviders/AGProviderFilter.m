//
//  AGProviderFilter.m
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGProviderFilter.h"

@implementation AGProviderFilter

/********************************	Accessors		********************************/
#pragma mark
#pragma mark Accessors

@synthesize gender = _gender;

/**
 Creates a new AGProviderFilter object with the specified gender
 @param gender An AGFilterGender enum value passed as the gender
 @return The new AGProviderFilter object
 */
-(id)initWithGender:(AGFilterGender)gender{
    if (self = [super init]){
        _gender = gender;
    }
    
    return self;
}

@end
