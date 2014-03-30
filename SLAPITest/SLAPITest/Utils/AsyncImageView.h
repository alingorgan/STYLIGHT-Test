//
//  AsyncImageView.h
//  GTSRealEstate
//
//  Created by Gorgan Alin on 2/13/14.
//  Copyright (c) 2014 Gorgan Alin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NetworkHelper/NHRequest.h"
#import "NetworkHelper/RequestConductor.h"

@interface AsyncImageView : UIImageView

/********************************	Methods   ********************************/
#pragma mark
#pragma mark Methods

/**
 Loads an image with the specified image url path
 @param imagePath The string url of the image
 @return void
 */
-(void)loadImageWithPath:(NSString*)imagePath;

@end
