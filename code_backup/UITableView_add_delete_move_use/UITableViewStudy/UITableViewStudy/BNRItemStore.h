//
//  BNRItemStore.h
//  UITableViewStudy
//
//  Created by admin on 2019/4/15.
//  Copyright © 2019 sk. All rights reserved.
//

#import <Foundation/Foundation.h>

// @class 告诉你编译器，某处代码定义了一个名为 BNRItem 的类，当某个文件只需要使用 BNRItem类的声明，而
// 无须知道具体的实现细节时，就可以使用该指令
// 使用该指令则不用在 BNRItemStore.h 中导入 BNRItem.h,就能将createItem方法的返回类型申明为指向
// BNRItem对象的指针
@class BNRItem;


@interface BNRItemStore : NSObject

@property (nonatomic,readonly) NSArray *allItems;     // 不可变数组
// 类方法
+ (instancetype)sharedStore;
- (BNRItem * )createItem;
- (void) removeItem: (BNRItem *) item;
- (void) moveItemsAtIndexe:(NSUInteger)fromIndex
                   toIndex:(NSUInteger)toIndex;
@end

