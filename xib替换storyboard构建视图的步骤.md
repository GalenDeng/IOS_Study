# xib替换storyboard构建视图的步骤 (2019/04/04)

* `具体步骤`
```
* find xxx.plist -> delete Main storyboard File base name

* 选中文件夹 -> 右键 -> new file -> View -> 修改XIB的名称(xib的名称不一定要喝控制器的名称一样，但要保证一个控制器只能有一个xib与其对应，多一个xib会导致run fail)-> create

* CLICK 该XIB文件 -> click file's owner -> 右侧的 inspect 检查器的左3(custom class) click -> select 该xib对应的 ViewController -> save -> click 右侧的 inspect 检查器的右1 -> (可能要长按 ctrl 拖动)拖动view 与 xib 的视图连接，变成 view  <-> View

* [这一步不一定要做，他是实现ViewController对象创建之后继续自定义的初始化设置罢了] 在该控制器 ViewController 添加方法 

   - (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    return self;
}

* 在 appdelegate 中要设置 self.window 是指哪个视图 (因为我们把 Main storyboard delete了，原有的 self.window 就没有指示对象了，需要自己手动新指示一个对象给 self.window)

    self.window = [[UIWindow alloc]initWithFrame:[[ UIScreen mainScreen] bounds] ];
    ViewController *viewControl = [[ViewController alloc] init];
    self.window.rootViewController = viewControl;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
```