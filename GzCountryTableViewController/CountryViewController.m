//
//  CountryViewController.m
//  Setting
//
//  Created by Gazolla on 21/04/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import "CountryViewController.h"



@interface CountryViewController ()

@end

@implementation CountryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _countries = [Countries sharedInstance];
    [_countries loadCountries];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,70,320,44)];
    [[self tableView] setTableHeaderView:self.searchBar];
    self.searchBar.delegate = (id)self;
    self.searchBar.showsCancelButton = YES; 
    self.isFiltered = NO;
    [self setContentSizeForViewInPopover:CGSizeMake(320, 500)];

    [[self tableView] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchBar delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    if(text.length == 0)
    {
        self.isFiltered = NO;
    }
    else
    {
        self.isFiltered = YES;
        self.filteredCountries = [[NSMutableArray alloc] init];
        
        for (NSString* countryName in _countries.countries)
        {
            NSRange nameRange = [countryName rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                [self.filteredCountries addObject:countryName];
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    self.searchBar.text = @"";
    self.isFiltered = NO;
    [self.tableView reloadData];
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int rowCount;
    if(self.isFiltered)
        rowCount = self.filteredCountries.count;
    else
        rowCount = [_countries.countries count];
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
        NSString *countryName  = (self.isFiltered) ? [self.filteredCountries objectAtIndex:indexPath.row] :
                                                     [_countries.countries objectAtIndex:indexPath.row];
        if ([countryName isEqualToString:self.currentItemString]) {
            self.checkedIndexPath = indexPath;
        }
        cell.textLabel.text = countryName;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        NSString *flagFileName = [_countries getFlagFileNameWithName:countryName];
        cell.imageView.image = [UIImage imageNamed:flagFileName];

        if (!(self.isFiltered)) {
            if([self.checkedIndexPath isEqual:indexPath]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Uncheck the previous checked row
    if(self.checkedIndexPath) {
        UITableViewCell* uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.checkedIndexPath = indexPath;
    self.currentItemString = (self.isFiltered) ? [self.filteredCountries objectAtIndex:indexPath.row]:
                                                 [_countries.countries objectAtIndex:indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
