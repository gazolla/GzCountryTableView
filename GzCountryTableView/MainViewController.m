//
//  MainViewController.m
//  GzCountryTableView
//
//  Created by Gazolla on 02/05/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [[Countries sharedInstance] loadCountries];
    _country = @"United States";
    _countryViewController = [[CountryViewController alloc] initWithStyle:UITableViewStyleGrouped];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    cell.textLabel.text = @"Country";
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:14];
    cell.detailTextLabel.text = _country;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [UIImage imageNamed:[[Countries sharedInstance] getFlagFileNameWithName:_country]];
    
    return cell;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqual:@"currentItemString"]) {
        _country = [_countryViewController currentItemString];
        [self.tableView reloadData];
        Countries *c = [Countries sharedInstance];
        [c loadCountries];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        _countryViewController.title = @"Countries";
        _countryViewController.currentItemString = _country;
        [_countryViewController addObserver:self forKeyPath:@"currentItemString" options:0 context:nil];
        [self.navigationController pushViewController:_countryViewController animated:YES];
    }
}

- (void)dealloc {
    // Remove observer.
    [self removeObserver:self forKeyPath:@"currentItemString"];
}


@end
