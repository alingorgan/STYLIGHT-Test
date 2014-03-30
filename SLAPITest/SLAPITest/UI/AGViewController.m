//
//  AGViewController.m
//  SLAPITest
//
//  Created by Alin Gorgan on 26/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import "AGViewController.h"
#import "NetworkHelper.h"
#import "NHRequest.h"
#import "RequestConductor.h"
#import "ResponseCart.h"

#import "AGResultsProvider.h"
#import "AGBoard.h"
#import "AGProduct.h"
#import "AsyncImageView.h"

@interface AGViewController()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) AGResultsProvider* provider;
@property (nonatomic, strong) AGProviderFilter* filter;

@end

@implementation AGViewController

/********************************	Constants		********************************/
#pragma mark
#pragma mark Constants

#define BATCH_RESULTS_SIZE 10


/********************************	Accessors		********************************/
#pragma mark
#pragma mark Accessors

@synthesize provider = _provider;
@synthesize filter = _filter;


/********************************	Access Modifiers		********************************/
#pragma mark
#pragma mark Access Modifiers

-(AGResultsProvider*)provider{
    if (_provider == nil){
        _provider = [[AGResultsProvider alloc] init];
        [_provider setBatchResultsSize:BATCH_RESULTS_SIZE];
        [_provider setDelegate:self];
    }
    
    return _provider;
}


-(AGProviderFilter*)filter{
    if (_filter == nil){
        _filter = [[AGProviderFilter alloc] initWithGender:AGFilterGenderMale];
    }
    
    return _filter;
}


/********************************	Methods		********************************/
#pragma mark
#pragma mark Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /**  Setup  */
    [self prepare];

}

/**
 Prepares the NetworkHelper module and starts loading the first batch
 @param none
 @return void
 */
-(void)prepare{
    /**  Setup the NetworkHelper  */
    [NetworkHelper setUp];
    
    /**  Load the first batch  */
    [self.provider loadNewResultsWithFilter:self.filter];

}

/**
 Customizes the given cell, from the given index path, with data
 @param cell The cell to be customized
 @param indexPath The cells indexPath
 @return void
 */
-(void)customizeCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    
    /**  Choose which data to add  */
    AGBoard* board = [self.provider.resultsArray objectAtIndex:indexPath.section];
    AGProduct* product = nil;
    id item = [board.productArray objectAtIndex:indexPath.row];
    if ([item isKindOfClass:[AGBoard class]]){
        AGBoard* tempBoard = (AGBoard*)item;
        product = [tempBoard.productArray objectAtIndex:0];
    }
    else{
        product = item;
    }
    
    /**  price formatter  */
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setCurrencySymbol:@"€"];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setMaximumFractionDigits:2];
    
    /**  Add the actual data  */
    [(UILabel*)[cell viewWithTag:1] setText:product.name];
    [(UILabel*)[cell viewWithTag:2] setText:[formatter stringFromNumber:[NSNumber numberWithFloat:product.price]]];
    [(AsyncImageView*)[cell viewWithTag:3] loadImageWithPath:product.imageURL];
}

/********************************	AGResultsProviderDelegate Methods		********************************/
#pragma mark
#pragma mark AGResultsProviderDelegate Methods

-(void)resultsProvider:(AGResultsProvider *)provider loadedNewResults:(NSArray *)newResults{
    /**  New results have come in, reload the table view  */
    [self.tableView reloadData];
}


/********************************	UITableViewDataSource Methods		********************************/
#pragma mark
#pragma mark UITableViewDataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    /**  A section for each item  */
    return self.provider.resultsArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    /**  A cell for each product  */
    return [[(AGBoard*)[self.provider.resultsArray objectAtIndex:section] productArray] count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    /**  Show the creator name (if any) as the section title  */
    NSString* creatorUserName = [(AGBoard*)[self.provider.resultsArray objectAtIndex:section] creatorUserName];
    if (creatorUserName == nil){
        return nil;
    }
    NSString* titleFormat = NSLocalizedString(@"UserBoardFormatted", @"");
    return [NSString stringWithFormat:titleFormat, creatorUserName];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"DefaultCellIdentifier";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self customizeCell:cell atIndexPath:indexPath];
    
    /**  We've reached the end of the list, load more results  */
    if (indexPath.section == self.provider.resultsArray.count - 1){
        [self.provider loadNewResultsWithFilter:self.filter];
    }
    
    return cell;
}

@end
