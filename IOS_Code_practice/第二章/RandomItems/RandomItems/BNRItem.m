//
//  BNRItem.m
//  RandomItems
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019年 sk. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

- (void)setItemName:(NSString *)str
{
    _itemName = str;
}

- (NSString *)itemName
{
    return _itemName;
}

- (void)setSerialNumber:(NSString *)str
{
    _serialNumber = str;
}

- (NSString *)serialNumber
{
    return _serialNumber;
}

- (void)setValueInDollars:(int)v
{
    _valueInDollars = v;
}

- (int)valueInDollars
{
    return _valueInDollars;
}

- (NSDate *)dateCreated
{
    return _dateCreated;
}


@end
