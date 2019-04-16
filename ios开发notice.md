# ios开发notice (2019/04/04)

* [GitBook简明教程](http://www.chengweiyang.cn/gitbook/index.html)

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
13. `访问视图的两种方式`
```
* 方式一 ：
//在应用启动后设置一次视图对象
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"ViewTestController loaded its view");
}

* 方式二 :

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 只允许用户选择一个距离现在至少60秒以后的时间
    // viewWillAppear: 该方法会在视图控制器的view添加到应用窗口之前被调用，且
    // 用户每次看到视图控制器的view时都要对其进行设置
    // animated参数用来设置是否使用视图显示或消失的动画
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}
```
* UITabBarController 不会显示过渡动画，而 UINavigationController在视图控制器被推入和推出屏幕时使用过渡动画

14. `Retina显示屏`
```
* 对于矢量图像，不用做任何处理就能在各种设备上有最好的显示效果
* 如果应用是通过 Core Graphics 函数绘图的，那么画出的图像在不同的设备上会有不同的显示效果
* Core Graphics 以点为单位描述线、曲线、文字等
* 非Retina显示屏，1个点是1个像素 ; 对于Retina显示屏，一个点是2像素 X 2像素
* 所以对于Retina显示屏显示的解决方式是: 在应用程序包里放入两套图，为高分辨率的图片文件加上后缀名 @2x ,
  当应用使用UIImage的imageNamed: 载入图片时，imageNamed: 会在程序包里查找并获取适合特定设备的文件
```
15. `UILabel and UITextField`
* UILabel: 它可以用来在界面中显示文本，但是用户无法选择或编辑 UILabel中的文本
* UITextField 可以接受用户输入的文本 [输入用户名和密码]

```
* 在视图控制器 xxxController.m 中加载某视图

- (void)loadView {
    // creat a view
    CGRect frame = [UIScreen mainScreen].bounds;
    ViewToDisplay *backgroundView = [[ViewToDisplay alloc]  initWithFrame: frame];
    
    CGRect textFiledRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFiledRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [backgroundView addSubview: textField];
    
    self.view = backgroundView;
}
```
16. `委托是Cocoa Touch中的一种常见设计模式`
17. `UIResponder`
```
* UIResponder 是 UIKit框架中的一个抽象类，而UIView/UIViewController/UIApplication等都是它的子类
* 除触摸时间由被触摸的视图负责处理【系统会将触摸事件直接发送给被触摸的视图】外，
  其他类型的事件都是由第一响应者负责处理
* UIWindow(应用窗口)有一个firstResponder属性指向第一响应者 
  example: 当用户点击UITextField对象时，UITextfield 对象就会成为第一响应者，UIWindow会将firstResponder指向该对象 -> 之后，如果应用接收到运动事件和功能控制事件，都会发送给UITextField对象
    UIWindow -> firstResponder -> UITextField
* 除点击事件外，我们可以通过代码给UITextField对象发送 becomeFirstResponder消息，使其成为第一响应者，给UITextField对象发送resignFirstResponder消息，要求该对象放弃第一响应者状态
```
```
* UIResponder 这个抽象类包括 UIView UIViewController UIApplication等子类
```
18. `委托理解`
```
* 之前我们click button , then execute a action , this pattern is called Target-Action design pattern , and deltete is also a design pattern in IOS'S development.
* 当遇到一些复杂的事件时，我们时常使用 delete 这种设计模式，委托，顾名思义就是 A人遇到某种情况，因为忙，就委托某个视图控制器对象去处理，而这个视图控制器就是一个委托对象（delete）,而处理这个情况的方法写在
这个控制器中，所以这个方法就称为委托方法。

    textField.delete = self ; // textfield 委托某个控制器处理某件事情，self指代当前文件的控制器对象

委托方法 example:

// 委托方法要在委托对象中实现
- (BOOL)textFieldShouldReturn: (UITextField * ) textField {
    NSLog(@"%@",textField.text);
    [textField resignFirstResponder];   // 关闭键盘
    return YES;
}

* 几乎所有的委托都是弱引用属性: 为了避免对象及其委托之间产生强引用循环，进而导致内存泄露
```

19. `协议`
```
* 凡是支持委托的对象，其背后都有一个相应的协议（JAVA和c#中，ios中的“协议”被称为“接口”），声明可以向该对象的委托对象发送的消息，委托对象根据协议中感兴趣的事件实现其相应的方法
```
* `协议编写示例`
```
// 声明协议 -- 协议不是一个类，而是一组方法声明，不能为协议创建对象，或者添加实例变量
// 协议自身不实现方法，需要由遵守相应协议的类来实现

// @protocol 指令开头   @end 结束标识   UITextFieldDelegate ： 协议名称
// <NSObject> : 声明 UITextFieldDelegate 包含 NSObject 协议的全部方法
@protocol UITextFieldDelegate <NSObject> 

// 声明 UITextFieldDelegate协议特有的方法
// 协议声明的方法类型 @required  and  @optional
// 委托协议中的方法通常都是可选的
@optional

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason NS_AVAILABLE_IOS(10_0); // if implemented, called in place of textFieldDidEndEditing:

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.

@end
```
* `@selector`
```
* 其是一种类型 SEL
* 代表你要发送的消息(方法)，跟字符串有点像，也可以互传 ： NSSelectorFromString()
* 可以理解为类似函数指针的东西 -- 是能让 Objective-C 动态调用方法的玩意 -- 是 objective-C 的动态后绑定技术，可以通过字符串访问的函数指针
* @selector(function_name)即取得一个 function 的 id

- (void) clearButtonTapped
{
    // textFieldShouldClear: 是可选方法，需要先检查委托是否实现了该方法
SEL = clearSelector = @selector(textFieldShouldClear:); // 取得 textFieldShouldClear: 的method_name
    if([self.delegate respndsToSelector: clearSelector]) {  // 发送方在发送可选方法前，会先向其委托对象发送
                                                            // 另一个名为 RespondsToSelector:的消息来判
                                                            // 断委托是否实现了该方法
        if([self.deletegate textFieldShouldClear:self]) {   // 执行 textFieldShouldClear 方法
            self.text = @"";                                // 清空操作
        }
    }    
}

```
```
* 如果某个协议的方法是必需的(required),则发送方可以直接向其委托对象发送相应的消息，不用检查委托对象是否实现了该方法，
  但是这样的效果是： 当委托对象没有实现这种方法，应用会抛出未知选择器（unrecognized selector）异常，导致应用崩溃，
* 为了防止上述此类问题的发生，编译器会检查某个类是否实现了相关协议的必须方法 -> 通过将相应的类声明为遵守指定的协议来开启编译器执行此类检查的操作 -> 语法格式：[在头文件或类扩展的@interface指令末尾，将类所遵守的协议以逗号分隔的列表形式写在尖括号里]

    @interface ViewController () <UITextFieldDelegate，xxx,xxx>     // xxx 表示的是协议


```
```
在调用respondsToSelector:@selector(method)时，这个method只有在该方法存在参数时需要 ":"，如果该方法不需要参数就不
需要加这个冒号。否则，编译不会报错，只是执行返回的值不对。当然如果方法有多个参数，需要多个冒号，参数有名称的需要带上参数
名称
```
```
　SEL　变量名　=　@selector(方法名字); 
　SEL　变量名　=　NSSelectorFromString(方法名字的字符串); 
　NSString　*变量名　=　NSStringFromSelector(SEL参数); 

其中第1行是直接在程序里面写上方法的名字，第2行是写上方法名字的字符串，第3行是通过SEL变量获得方法的名字。我们得到了SEL变量之后，可以通过下面的调用来给一个对象发送消息： 

　[对象　performSelector:SEL变量　withObject:参数1　withObject:参数2]; 

　这样的机制大大的增加了我们的程序的灵活性，我们可以通过给一个方法传递SEL参数，让这个方法动态的执行某一个方法；我们也可以通过配置文件指定需要执行的方法，程序读取配置文件之后把方法的字符串翻译成为SEL变量然后给相应的对象发送这个消息。 

　从效率的角度上来说，执行的时候不是通过方法名字而是方法ID也就是一个整数来查找方法，由于整数的查找和匹配比字符串要快得多，所以这样可以在某种程度上提高执行的效率。
```
* `self`
```
* self是指针，指向运行当前方法的对象，当某个对象要向自己发送消息时，就需要使用self

* example
-- 假设BNRPerson类有一个名为 addYourselfToArray: 的方法，代码如下：
- (void) addYourselfToArray:(NSMutableArray *)theArray
{
    [theArray addObject:self];  // 这里的self其实就是 BNRPerson实例的地址
}
```
20. `UILabel operation`
* `label 适应文字尺寸大小`
```
* UILabel *messageLabel = [ [UILabel alloc] init ];
*[ messageLabel sizeToFit ]; // 根据需要显示的文字调整UILabel对象的大小
```
* `自定义UILabel在视图的位置`
```
CGRect frame = messageLabel.frame;
frame.origin = CGPointMake(x,y);
messageLabel.frame = frame;

[self.view addsubview:messageLabel];
```
* `运动效果`
```
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;

        [messageLabel sizeToFit];

        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random_uniform(width);

        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random_uniform(height);

        // Update the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        [self.view addSubview:messageLabel];

        // use 具有运动效果的class
        UIInterpolatingMotionEffect *motionEffect;
        // 设置水平、键路径（key path,需要视差效果的属性，这里是 center.x）
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        // 视差的范围 -- 相对最小/最大值
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        // 添加到某视图上
        [messageLabel addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @-25;
        motionEffect.maximumRelativeValue = @25;
        [messageLabel addMotionEffect:motionEffect];
    }
```
21. `Xcode 调试器使用方法介绍`
* 使用方法参考 《iOS编程》(第4版) --- 【 P153 - P156 】
* `特别注意`
```
* 当我们执行app遇到了应用崩溃问题，并且无法找到错误原因时，就可以通过添加异常断点定位有问题的代码
* 当我们找不到应用崩溃的原因时，可以再断点导航面板中检查断点，也许“崩溃”其实是由某个被遗忘的断点造成的
```
22. `main() 和 UIApplication`
```
* 无论使用c语言还是Objective-C语言编程，其执行入口都是 main()
```
```
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

*  [AppDelegate class] : return class object

*  NSStringFromClass(xxx) : Returns the name of  xxx class as a string.

*  UIApplicationMain : 
1. 该函数会创建一个 UIApplication 对象 -> 该对象在每个ios应用里只有唯一一个
2. UIApplicationMain 还会创建 NSStringFromClass 指定的类的对象，并将其设置为 UIApplication对象的delegate
3. 在应用启动运行循环并开始接收事件前，UIApplication对象会向其委托发送application:didFinishLaunchingWithOptions: 这个消息，使应用能有机会完成相应的初始化工作 -> 譬如：创建UIWindow对象和多个视图控制对象

*  UIApplication 的作用是维护运行循环，一旦程序里有创建某个UIApplication对象，该对象的运行循环就一直循环，main()的执行也会因此阻塞
```
23. `UITableView 与 UIViewController`
* ios界面使用某种列表控件：用户可以选中、删除、重排列表中的条目 -> 这些控件其实都是 UITableView对象 -> 显示一组对象
* UITableView 只能显示一列数据
* UITableViewController可以作为视图控制对象、数据源、委托对象
* 凡是遵守UITableViewDelegate协议的对象，都可以成为UITableView对象的委托对象
* 凡是遵守UITableViewDataSource协议的objective - c 对象，都可以成为UITableView对象的数据源（即dataSource属性所指向的对象）
* NSString 的 NS = Next Step
* UITableViewController 的指定初始化方法是： initWithStyle:  参数常量： UITableViewStylePlain or UITableViewStyleGrouped
* 因为 UITableViewController有view方法，view方法会调用loadView方法，如果视图不存在，则loadView方法会创建并载入一个空的视图

24. `MVC`
```
* 模型： 负责存储数据，与用户界面无关
* 视图： 负责显示界面，与模型对象无关
* 控制器： 负责确保视图对象和模型对象的数据保持一致
```


