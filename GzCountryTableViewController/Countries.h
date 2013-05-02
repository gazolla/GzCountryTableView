//
//  Countries.h
//  Setting
//
//  Created by Gazolla on 21/04/13.
//  Copyright (c) 2013 Gazolla. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Countries : NSObject

@property (strong) NSArray *countries;
@property (strong) NSDictionary *codeForCountryDictionary;

+ (Countries *)sharedInstance;
-(void)loadCountries;
-(NSString *) getFlagFileName:(NSUInteger) index;
-(NSString *) getFlagFileNameWithName:(NSString *) countryName ;
-(NSString *) getCountryCode:(NSString *) countryName;

@end
