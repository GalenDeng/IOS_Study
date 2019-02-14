//
//  BNRItem.h
//  RandomItems
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019年 sk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

{
NSString *_itemName;
NSString *_serialNumber;
int _valueInDollars;
NSDate *_dateCreated;
}

- (void)setItemName:(NSString *)str;
- (NSString *)itemName;

- (void)setSerialNumber:(NSString *)str;
- (NSString *)serialNumber;

- (void)setValueInDollars:(int)v;
- (int)valueInDollars;

- (NSDate *)dateCreated;
@end
