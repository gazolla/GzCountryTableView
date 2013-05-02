//
//  MainViewController.h
//  GzCountryTableView
//
//  Created by Gazolla on 02/05/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryViewController.h"
#import "Countries.h"

@interface MainViewController : UITableViewController

@property (nonatomic,strong) CountryViewController *countryViewController;
@property (nonatomic,strong) NSString *country;

@end
