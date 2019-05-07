//
//  BNRItem.h
//  UITableViewStudy
//
//  Created by admin on 2019/4/15.
//  Copyright © 2019 sk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

+ (instancetype)BNRSetMethod;

// custom initial method
- (instancetype)initWithName:(NSString *)name
                         old:(NSString *)old;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *old;

@end

