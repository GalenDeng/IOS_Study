# ios开发notice (2019/04/04)

1. `Interfaces Builder连线规则`
```
* A导致B发生change , so A 连线到 B
```
2. `记住xib的view 要和file's owner represent 的class 连线`

3. `视图嵌入多视图的方式 -- code embedded`
```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[ UIScreen mainScreen] bounds] ];
    ViewController *viewControl = [[ViewController alloc] init];
    self.window.rootViewController = viewControl;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    CGRect subViewFrame = CGRectMake(240, 240, 50, 50);  // CGRect占用的内存比大部分对象小，因此不传入指针
    UIView   *subView  = [[UIView alloc] initWithFrame:subViewFrame ];
    subView.backgroundColor = [UIColor yellowColor];
    
    [self.window addSubview:subView];
    
    return YES;
}
```
4. `bounds 和 frame`
```
* 表示的矩形位于自己的坐标系，而frame表示的矩形位于父视图的坐标系，但是两个矩形的大小是相同的
```
```
* 充满屏幕 CGRect viewframe = self.window.bounds;
```
5. `类扩展`
```
* 声明方式：
@interface xxx ()
@property (nonatomic) UIColor *circle;
@end
```
* 子类/其他类 都无法访问父类在类扩展中声明的属性和方法，例如这里无法访问 circle
* 类扩展用来隐藏内部实现细节
6. `触摸事件`
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor blueColor];
}
```
7. `UIScrollView 的关键点`
```
* UIScrollView 对象适用于那些尺寸大于屏幕的视图
* 将 UIScrollView 对象看成是镜头 ，而子视图是拍摄的景观
* 能够拍摄的范围由属性 contentSize决定的，contentSize的数值就是子视图的尺寸
* 可以将UIScrollView作为子视图添加到其他视图中
* 即超大尺寸的视图A 作为 UIScrollView (镜头)的子视图
* UIScrollView还可以实现“Pinch-to-zoom”(捏合缩放)
* UIScrllView 继承至 UIView
```
```
     /******************** UIScrollView的拖动与分页应用 **************************/
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect ];
    [scrollView setPagingEnabled:true];     // 解决同时显示两个不同View的情况，另UIScrollView 对象的边和其显示的某个视图的边对齐
    [self.window addSubview:scrollView];
    
    ViewToDisplay *thirdView = [[ViewToDisplay alloc] initWithFrame:screenRect ];
    [scrollView addSubview:thirdView];
    
    screenRect.origin.x += screenRect.size.width;
    ViewToDisplay *forthView = [[ViewToDisplay alloc] initWithFrame:screenRect ];
    [scrollView addSubview:forthView];
    
    // scrollView 对象取景范围
    scrollView.contentSize = bigRect.size;
```
8. `视图控制器 - UIViewController类`
* 一个视图控制器可以管理一个视图层次结构
* `创建视图层次结构的两种方式`
```
1. 代码方式：覆盖UIViewController中的loadView方法
2. NIB文件方式：使用 Interface Builder 创建一个 Nib文件，然后加入所需的视图层次结构，最后视图控制器
会在运行时加载由该NIB文件编译而成的XIB文件。
```
* `1. 视图创建`
```
@implementation xxxController 

- (void) loadView {
    xxxView *xxxview = [ [xxxView alloc] init ];
    // 将xxxView 对象赋给视图控制器的view属性
    self.view = xxxview;
}

@end


* 视图刚被创建时，其view属性会被初始化为 nil , 之后，当应用需要将该视图控制器的视图显示到屏幕上时，
  如果view属性是nil,就会自动调用loadView方法
```
* `2.视图加载 - 设置根控制器`
```
    self.window = [[UIWindow alloc]initWithFrame:[[ UIScreen mainScreen] bounds] ];
    ViewController *viewControl = [[ViewController alloc] init];
    self.window.rootViewController = viewControl;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
```
* `当某个视图控制器的view拥有子视图时，使用 Interface Builder 创建视图层次结构会方便很多`
```
* IBOutlet 和 IBAction 关键字告诉xcode,这些属性或方法之后会在Interface Builder中关联
```
* `3.创建xib文件 -- 进行关联操作[关联 File's Owner]`
```
* caution
1. file's owner 要选择相应的 class
2. 关联 View <---> view : 当xxxController对象载入该XIB文件时，其view属性就自动指向画布中的UIView对象
3.关联 IBOutlet变量和 IBAction 方法
```
```
* 对象库面板拖曳一个UIView对象至画布，默认情况下，该对象的大小和屏幕大小相同，不需要手动调整其大小
```
3. 当视图控制器从Nib文件中创建视图层次结构时，`不需要覆盖loadView方法`,默认的loadView方法会自动处理NIB文件中包含的视图层次结构
```
self.window = [[UIWindow alloc]initWithFrame:[[ UIScreen mainScreen] bounds] ];
    // 获取指向NSBundle对象的指针，该NSBundle对象代表应用的主程序包
    // 向NSBundle发送 mainBundle消息可以得到应用的主程序包，主程序包对应文件系统中项目的根目录，包含
    // 代码文件和资源文件（例如NIB文件和图片）
    NSBundle *appBundle = [NSBundle mainBundle];
    
    // 告诉初始化方法在appBundlez程序包中查找ViewTest.xib文件
    ViewTestController *viewtestcontroller = [[ViewTestController alloc] initWithNibName:@"ViewTest" bundle:appBundle ];         // ViewTest 为指定的NIB文件的文件名 appBundle是指定的所在程序包
    self.window.rootViewController = viewtestcontroller;    // 根视图
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
```

* `将插座变量声明为弱引用是一种编程约定`
```
* 当系统的可用内存偏少，视图控制器会自动释放其视图并在之后需要显示时再创建 -> 因此，视图控制器应该使用弱引用特性的插座变量指向view的子视图以便在释放view时同时释放view的所有子视图，从而避免内存泄露
```

9. `切换视图 -- UITabBarController`
```
* UITabBarController中可包括多个视图控制器
* appdelegate:

self.window = [[UIWindow alloc]initWithFrame:[[ UIScreen mainScreen] bounds] ];
    ViewController *viewcontroller = [[ViewController alloc] init ];
    
    // 获取指向NSBundle对象的指针，该NSBundle对象代表应用的主程序包
    NSBundle *appBundle = [NSBundle mainBundle];
    
    // 告诉初始化方法在appBundlez程序包中查找ViewTest.xib文件
    ViewTestController *viewtestcontroller = [[ViewTestController alloc] initWithNibName:@"ViewTest" bundle:appBundle ];
    
    UITabBarController *tabcontroller = [[UITabBarController alloc] init ];
    tabcontroller.viewControllers = @[viewcontroller,viewtestcontroller];   // 包括两个视图控制器
    
    self.window.rootViewController = tabcontroller;    // 根视图
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
```
```
* 另外两个视图控制器.m添加标签（文字+图片）
* 图片要放到资源目录中的文件列表中，如： Assets.xcassets

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // 设置标签项的标题
        self.tabBarItem.title = @"ViewController";
        // 从图像文件中创建一个UIImage对象
        // 在Retina显示屏上会加载Hypno@2x.png,而不是Hypno.png
        UIImage *i= [UIImage imageNamed:@"Hypno.png"];
        // 将UIImage对象赋给标签项的image属性
        self.tabBarItem.image = i;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        // 设置标签项的标题
        self.tabBarItem.title = @"ViewTestController";  // 标签文字
        // 从图像文件中创建一个UIImage对象
        // 在Retina显示屏上会加载Time@2x.png,而不是Time.png
        UIImage *i= [UIImage imageNamed:@"Time.png"];
        // 将UIImage对象赋给标签项的image属性
        self.tabBarItem.image = i;                      // 标签图片
    }
    return self;
}

```

10. `视图控制器的初始化方法`
```
* 向视图控制器发送init消息会调用initWithNibName:bundle：方法并为两参数传入nil

* 建议视图控制器名称和其控制的XIB文件的名称一致，这样的话，当视图控制器需要加载视图时，
  会自动载入正确的XIB文件
```
11. `本地通知`
```

```
12. `viewDidLoad`
```
* 视图控制器的viewDidLoad 方法检查视图控制器的视图是否已经加载
* 每个控制器对象都实现了viewDidLoad方法，该方法会在载入视图后立刻被调用
* 通过NSLog打印来观察控制器控制器的视图是否已经加载
```
```
* 为了实现视图的延迟加载，在 initWithNgibName:bundle: 中不应该访问view或view的任何子视图
* 凡是和view或view的子视图有关的初始化代码，都应该在 viewDidLoad 方法中实现，避免加载不需要
  在屏幕上显示的视图
```

