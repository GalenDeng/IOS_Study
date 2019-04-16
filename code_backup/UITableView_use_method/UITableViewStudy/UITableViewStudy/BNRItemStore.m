//
//  BNRItemStore.m
//  UITableViewStudy
//
//  Created by admin on 2019/4/15.
//  Copyright © 2019 sk. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore {
    static BNRItemStore *sharedStore; // 静态变量在方法返回时，不会释放静态变量
    
    // 判断是否已经创建了一个 sharedStore 对象 [单例]
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate ];
    }
    
    return sharedStore;
}

// 如果调用 [[BNRItemStore alloc] init ],就提示应该使用 [BNRItemStore sharedStore]

- (instancetype)init
{
    // 扔出提示信息
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use + [BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}

- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        _privateItems = [[NSMutableArray alloc] init ];
    }
    return self;
}

- (NSArray *) allItems {
    return [self.privateItems  copy];
}

- (BNRItem *)createItem {
    BNRItem *item = [BNRItem BNRSetMethod ];
    [self.privateItems addObject:item];
    
    return item;
}

@end
