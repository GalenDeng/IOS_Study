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