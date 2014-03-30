//
//  AGViewController.h
//  SLAPITest
//
//  Created by Alin Gorgan on 26/03/14.
//  Copyright (c) 2014 Alin Gorgan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGResultsProvider.h"

@interface AGViewController : UIViewController <AGResultsProviderDelegate, UITableViewDataSource, UITableViewDelegate>

@end
