# NSBundle mainBundle 在 framework等staticlib的使用注意 (2019.09.18)

1. `framework / .a 静态库中使用 NSBundle mainBundle`
```
* 在静态库中使用 NSBundle mainBundle 的时候，这个时候我们获取的是另一个主工程的bundle路径(该主工程使用了这些静态库的内容)，而无法获取到静态库的bundle路径
```
2. `framework 加载和访问 bundle 资源搭建`
* [静态库访问bundle资源方式](https://www.jianshu.com/p/c92c08d8afda)
```
detail :

* 把在静态库中需要访问的资源放在静态库的bundle中
* 在主工程中的 link binary with libraries 中添加该 xxx.framework
* Build Phases -> New Copy Files Phase （静态库Framework读取资源需要add a copy file）
* Copy Files 中添加该 xxx.framework

* 该xxx.framework静态库通过下面的方式访问资源
NSString *path = [[NSBundle mainBundle]pathForResource:@"IOSWirelessSDK.framework/JMError" ofType:@"plist"];
```