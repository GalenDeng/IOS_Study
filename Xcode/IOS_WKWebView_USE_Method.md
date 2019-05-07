# The use method of WKWebView

* [Failed to instantiate the default view controller for UIMainStoryboardFile 'Main'](https://blog.csdn.net/csdn_hhg/article/details/51182370)
* [WKWebView 点击链接无反应](https://blog.csdn.net/akaier/article/details/51397959)

1. `WKWebView 与 WebView 对比`
```
* WKWebView相比UIWebView消耗的内存更少
* 使用WKWebView便等于使用和Safari中相同的JavaScript解释器,用来替代过去的UIWebView
```
* [使用WKWebView在iOS应用中调用Web的方法详解](https://www.cnblogs.com/liyingnan/p/5667264.html) 

2. `网页跳转`
* `caution`
```
我们会发现网页上列表里的文字,包括顶栏上的文字点击了没反应,问题出在哪里呢?这是因为系统阻止了不安全的连接。
怎么解决呢？我们就要用到WKUIDelegate中的createWebViewWithConfiguration()这个方法让其允许导航,首
先我们要设置自身代理,在viewDidLoad()里加上 self.webview.UIDelegate = self
```
```
#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController () <WKNavigationDelegate> //该控制器遵守WKNavigationDelegate协议

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Jump to a particular method of web pages
     WKWebView *myWKWebView = [[WKWebView alloc]initWithFrame:self.view.bounds];
     NSURL *url = [NSURL URLWithString:@"http://www.jolimark.com/"];
   //NSURL *url = [NSURL URLWithString:@"https://www.jolimark.com/"];  // 这个是安全的网址  
     NSURLRequest *req = [NSURLRequest requestWithURL:url];
     [myWKWebView loadRequest:req];
     [self.view addSubview:myWKWebView];
    // ViewController 作为委托
     myWKWebView.UIDelegate = self;
    
}

// 委托方法
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    NSLog(@"createWebViewWithConfiguration");
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}
```
3. `要访问到不安全的网站：http：// xxx , 我们需要在info.plist中添加下面的代码`
* `访问 https://xxx 的时候也要添加下列的代码` --- `WKWebView`
```
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```
* [iOS访问http请求不成功的解决方法](https://blog.csdn.net/liuyinghui523/article/details/79376755)

4. `添加WebView的backward and forward method`
```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // create WKWebView
    [self createWebView];
    
    // backward and forward function implementation
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];
}

-(void)goback{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        NSLog(@"back");
    }
}
-(void)gofarward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}
```