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

// 类扩展
// 因为 headView 指向XIB文件中的顶层对象，所以必须为强引用
// 当插座变量指向顶层对象所拥有的对象（如顶层对象的子视图时，应使用弱引用
@property (nonatomic,strong) IBOutlet UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
    // 使用 headView 方法手动加载 HeaderView.xib 文件
    UIView *header = self.headView;
    // 设置 tableView 的表头视图是header
    [self.tableView setTableHeaderView:header];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
       /* for (int i = 0; i< 3 ; i++) {
            [[BNRItemStore sharedStore] createItem];
        }*/
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

- (IBAction)addNewItem:(id)sender {
    // 创建新对象
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    
    // 获取新对象在allItems 数组中的索引
    NSInteger *lastRow = [[[BNRItemStore sharedStore] allItems ]  indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow
                                                inSection:0];
    // 将新行插入 UITableView对象
    // 注意 @[indexPath]
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationTop];
}

// toggle : 切换的意思
- (IBAction)toggleEditingMode:(id)sender {
    if(self.isEditing) {
        // 修改提示文字
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
        // 关闭编辑模式
        [self setEditing:NO
                animated:YES];
    } else {
        // 修改按钮文字，提示状态
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        // 开启编辑模式
        [self setEditing:YES
                animated:YES];
    }
}

- (UIView *)headView {
    // 如果还没载入headerView...
    // 这里使用了延迟实例化的设计模式：只会在真正需要使用某个对象时再创建它：某些情况下可显著减少内存占用
    if (!_headerView) {
    // 使用NSBundle类可以载入指定的XIB文件，该类是“应用程序包”和“应用程序包所包含的可执行文件”之间的接口
    // 通过该类，应用可以访问某个程序包中的文件
        
        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                      owner:self
                                    options:nil];
    }
    return _headerView;

}

// delete operation (object and table's row)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果UITableView对象请求确认的是删除操作...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        // delete object
        [[BNRItemStore sharedStore] removeItem:item];
        // 还要删除表格视图中的相应表格行（带动画效果）
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}

//move location
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemsAtIndexe:sourceIndexPath.row
                                          toIndex:destinationIndexPath.row];
}

@end
