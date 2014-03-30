//
//  UIImage+Utils.h
//  GTSRealEstate
//
//  Created by Gorgan Alin on 1/27/14.
//  Copyright (c) 2014 Gorgan Alin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Creates a new image using a specified background color
 Note that the initial size of the image will be 1.0f x 1.0f
 @param color The background color of the image
 @return The new image created
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 Creates a new image using a specified background color
 @param color The background color of the image
 @param rect The initial size of the image
 @return The new image created
 */
+ (UIImage *)imageWithColor:(UIColor *)color inRect:(CGRect)rect;


@end
