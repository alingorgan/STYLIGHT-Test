//
//  AGProviderFilter.h
//  SLAPITest
//
//  Created by Alin Gorgan on 30/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGProviderFilter : NSObject

/********************************	AGFilterGender Enum		********************************/
#pragma mark
#pragma mark AGFilterGender Enum

typedef enum AGFilterGender {
    AGFilterGenderMale = 0,
    AGFilterGenderFemale = 1
} AGFilterGender;


#define GenderFilterValue(filterGender) [@[@"men",@"women"] objectAtIndex:filterGender]

/********************************	Properties		********************************/
#pragma mark
#pragma mark Properties

@property (nonatomic) AGFilterGender gender;


/********************************	Initializers    ********************************/
#pragma mark
#pragma mark Initializers

/**
 Creates a new AGProviderFilter object with the specified gender
 @param gender An AGFilterGender enum value passed as the gender
 @return The new AGProviderFilter object
 */
-(id)initWithGender:(AGFilterGender)gender;

@end
