//
//  AGProduct.h
//  SLAPITest
//
//  Created by Gorgan Alin on 3/28/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGProduct : NSObject

/********************************	Properties		********************************/
#pragma mark
#pragma mark Properties

@property (nonatomic, strong) NSString* name;
@property (nonatomic) float price;
@property (nonatomic, strong) NSString* imageURL;

@end
