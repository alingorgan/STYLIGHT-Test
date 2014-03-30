//
//  AsyncImageView.m
//  GTSRealEstate
//
//  Created by Gorgan Alin on 2/13/14.
//  Copyright (c) 2014 Gorgan Alin. All rights reserved.
//

#import "AsyncImageView.h"
#import "UIImage+Utils.h"

@interface AsyncImageView()

@property (nonatomic, strong) NSString* imagePath;
@property (nonatomic) NSInteger requestTicket;

@end

@implementation AsyncImageView

/********************************	Accessors		********************************/
#pragma mark
#pragma mark Accessors

@synthesize imagePath = _imagePath;


/********************************	Access Modifiers		********************************/
#pragma mark
#pragma mark Access Modifiers

-(void)setImagePath:(NSString *)imagePath{
    if (![_imagePath isEqualToString:imagePath]){
        _imagePath = imagePath;
        
        [self loadImage];
    }
}

/********************************	Initializers		********************************/
#pragma mark
#pragma mark Initializers

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}


/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

/**
 Loads an image with the specified image url path
 @param imagePath The string url of the image
 @return void
 */
-(void)loadImageWithPath:(NSString*)imagePath{
    [self setImagePath:imagePath];
}

/**
 Loads an image with a predefined image url path
 @param none
 @return void
 */
-(void)loadImage{
    /**  remove the current image  */
    [self setImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    /**  Request the new image.  */
    if (self.imagePath == nil){
        return;
    }
    
    /**  Create a request for the image  */
    NHRequest* request = [NHRequest requestWithURL:[NSURL URLWithString:self.imagePath]];
    self.requestTicket = [[RequestConductor sharedConductor] performRequest:request
                                                         andCompletionBlock:^void(ResponseCart** responseCart) {
                        
                        /**  Create the image */
                        UIImage* image = [UIImage imageWithData:(*responseCart).responseData];
                                                             
                        dispatch_async(dispatch_get_main_queue(), ^{
                            /* Choose whether it's retrieved as a result to the latest request, by comparing the request ticket.  */
                            if (self.requestTicket == (*responseCart).ticket) {
                                [self setBackgroundColor:[UIColor blackColor]];
                                [self setImage:image];
                            }
                        });
                     }];
}


@end
