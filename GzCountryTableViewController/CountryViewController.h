//
//  CountryViewController.h
//  Setting
//
//  Created by Gazolla on 21/04/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Countries.h"

@interface CountryViewController : UITableViewController


@property (strong) Countries *countries;
@property (nonatomic, strong) NSString *currentItemString;
@property (nonatomic) int currentItem;
@property (nonatomic, strong) NSIndexPath* checkedIndexPath;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *filteredCountries;
@property (assign) BOOL isFiltered;

@end



