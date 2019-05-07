//
//  BNRItem.m
//  UITableViewStudy
//
//  Created by admin on 2019/4/15.
//  Copyright © 2019 sk. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

+(instancetype)BNRSetMethod {
    NSArray *nameList = @[@"Galen",@"Jenny",@"Gogo"];
    NSArray *oldList = @[@"26",@"24",@"22"];
    
    NSInteger nameIndex = rand() % [nameList count];
    NSInteger oldIndex  = rand() % [oldList count];
    
    NSString *name = [NSString stringWithFormat:@"%@",nameList[nameIndex]];
    
    NSString *old  = [NSString stringWithFormat:@"%@",oldList[oldIndex]];
    
    BNRItem *bnrItem = [[self alloc]initWithName:name
                                             old:old ];
    return bnrItem;
    
    
}

- (instancetype)initWithName:(NSString *)name old:(NSString *)old {
    self = [super init];
    if (self) {
        self.name = name;
        self.old = old;
    }

    return self;
}

- (instancetype) init {
    return [self initWithName:@"123"
                          old:@"11"];
}

- (NSString *)description
{

    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"name = %@, old = %@",
     self.name,
     self.old ];
     
     return descriptionString;

}

     - (void)dealloc
    {
        NSLog(@"Destroyed: %@", self);
    }
     
@end
