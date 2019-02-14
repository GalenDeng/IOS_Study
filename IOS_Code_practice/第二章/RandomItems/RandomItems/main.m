//
//  main.m
//  RandomItems
//
//  Created by admin on 2019/2/14.
//  Copyright © 2019年 sk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //NSLog(@"Hello, World!");
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
        [items addObject:@"one"];
        [items addObject:@"two"];
        [items addObject:@"three"];
        
        [items insertObject:@"Zero" atIndex:0];
        
        // 快速枚举
        for (NSString *item in items) {
            NSLog(@"%@",item);
        }
        
        // 传统for循环
        /*for(int i =0;i< [items count];i++) {
            NSString *item = [items objectAtIndex:i];
            NSLog(@"%@",item);
        }*/
        BNRItem *item = [[BNRItem alloc] init];
        //initlize
        item.itemName =  @"Red Sofa";
        [item setSerialNumber:@"A1B2C"];
        [item setValueInDollars:100];
        
        NSLog(@"%@  %@ %@ %d",[item itemName],[item dateCreated],[item serialNumber],[item valueInDollars]);
        
        // 释放对象
        items = nil;
    }
    return 0;
}
