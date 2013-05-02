//
//  Countries.m
//  Setting
//
//  Created by Gazolla on 21/04/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import "Countries.h"

@implementation Countries


/***********************************************************************
 * Singleton Implementation
 */

+ (Countries *)sharedInstance
{
    static Countries *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Countries alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}
/***********************************************************************/


// This method load all countries from appstore_countries.txt to codeForCountryDictionary
-(void)loadCountries{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"appstore_countries" ofType:@"txt"];
    NSString *file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    _countries = [file componentsSeparatedByString:@"\n"];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                          
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    NSMutableArray *countries = [NSMutableArray arrayWithCapacity:[countryCodes count]];
    
    for (NSString *countryCode in countryCodes){
        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
        NSString *country = [usLocale displayNameForKey: NSLocaleIdentifier value: identifier];
        [countries addObject: country];
    }
    
    _codeForCountryDictionary = [[NSDictionary alloc] initWithObjects:countryCodes forKeys:countries];
}

//Get the flag fileName from index position in the file
-(NSString *)getFlagFileName:(NSUInteger) index {
    return [[[_countries objectAtIndex:index] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//Get the flag fileName from country name
-(NSString *)getFlagFileNameWithName:(NSString *) countryName {
    return [[countryName lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//Get the country code by the country name
-(NSString *) getCountryCode:(NSString *) countryName {
    countryName = [countryName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [_codeForCountryDictionary objectForKey:countryName];
}

@end
