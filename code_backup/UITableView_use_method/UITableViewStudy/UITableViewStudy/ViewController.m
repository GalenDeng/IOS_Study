//
//  ViewController.m
//  UITableViewStudy
//
//  Created by admin on 2019/4/15.
//  Copyright © 2019 sk. All rights reserved.
//

#import "ViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        for (int i = 0; i< 3 ; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    NSLog(@"sizeof(NSInteger) = %@", @(sizeof(NSInteger)));
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems]  count]; // 获取显示的行数
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *uiTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                            forIndexPath: indexPath ];
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    uiTableViewCell.textLabel.text = [item description];
    return uiTableViewCell;
}

@end
