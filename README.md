#GzCountryTableView

A `GzCountryTableView` is a UITableView preload with appStore Countries and flags. The objective of this is to provide a way to pick one country from a list with a Search mechanism.

![](https://github.com/gazolla/GzCountryTableView/raw/master/GzCountryTblVw.png)


##Supported Platforms

- iOS 6+

##Installing

In order to install `GzCountryTableView`, you'll need to copy the GzCountryTableViewController folder into your Xcode project. 

###Usage

In order to use `GzCountryTableView`, you'll need to include the following code in your project:

    CountryViewController *countryViewController = [[CountryViewController alloc] initWithStyle:UITableViewStyleGrouped];
  	countryViewController.title = @"Countries";
    countryViewController.currentItemString = _country;
    [countryViewController addObserver:self forKeyPath:@"currentItemString" options:0 context:nil];
    [self.navigationController pushViewController:_countryViewController animated:YES];
        
And implement the KVO method:

    -(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
        if ([keyPath isEqual:@"currentItemString"]) {
            _country = [_countryViewController currentItemString];
            [self.tableView reloadData];
            Countries *c = [Countries sharedInstance];
            [c loadCountries];
        }
    }


if you want to add or remove a country from the tableView, just edit the `appstore_countries.txt` file locate at flags directory `/GzCountryTableViewController/flags`


 
##Credits & Contributors

`GzCountryTableView` was written by [Sebastian Gazolla Jr][1].

  [1]: http://gazapps.com
Website: http://gazapps.com/  
Google+: http://gplus.to/gazollajr  
Twitter: http://twitter.com/gazollajr
  
##License

`GzCountryTableView` is licensed under the MIT license, which is reproduced in its entirety here:


>Copyright (c) 2013 Sebastian Gazolla Jr
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in
>all copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>THE SOFTWARE.
