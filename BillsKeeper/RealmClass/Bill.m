//
//  Bill.m
//  BillsKeeper
//
//  Created by DOUINEAU Romain on 19/03/2015.
//  Copyright (c) 2015 DOUINEAU Romain. All rights reserved.
//

#import "Bill.h"

@implementation Bill

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Facture X";
        self.dateBill = [NSDate date];
        self.dateShoot = [NSDate date];
        self.imageLink = @"noimg.png";
        self.category = @"Other";
        self.user = @"noUser";
        self.objectId = [self randomNumberBetween:99999 maxNumber:999999999];
    }
    return self;
}

- (int)randomNumberBetween:(int)min maxNumber:(int)max
{
    return (int)min + arc4random_uniform(max - min + 1);
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

+ (NSString *)primaryKey {
    return @"objectId";
}

@end
