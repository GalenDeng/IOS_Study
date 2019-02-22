## Caution (2019.01.16)
* `git推送`
```
* git remote add origin git@github.com:GalenDeng/IOS_Study.git
* git push -u origin master
```
* [CocoaPods的基本使用方法](https://www.cnblogs.com/jcy23401/p/4676616.html)

* `block语法`
```
void (^animations)(void) = ^{ }；
这是一个block代码块，表示一个变量名为animations，无参数，无返回值的函数。
{}这里面放的是回调执行的代码，至于回调是什么意思，你去cocoachina看下基础知识就可以了
```
* `Can't create handler inside thread that has not called Looper.prepare()错误`
```
因为toast的实现需要在activity的主线程才能正常工作，所以传统的非主线程不能使toast显示在actvity上，通过Handler可以使自定义线程运行于Ui主线程。

解决办法：
Looper.prepare();
Toast.makeText(getApplicationContext(), "test", Toast.LENGTH_LONG).show();
Looper.loop();
```

## 1. 通过 adb调试程序
* `应用场景` 
```
平板电脑已经和打印机通过usb连接了，此时我想在电脑上查看logcat,
但是平板已经和打印机连接了，我要调试就要使用 network(网络)的方式进行adb的调试
```
* 平板上在开发者选项那里打开usb调试，adb调试，选择调试的app应用
* 通过网口连接打印机和电脑，ping一下两者是否互通
* 电脑进入终端，进入到android sdk的 platform-tools/目录下
```
* admindeMacBook-Pro:android-sdk-cli admin$ adb connect 192.168.7.10
already connected to 192.168.7.10:5555

即adb 通信成功
```
* 在android-studio中，run -> 选择该usb设备【BY IP TO select】
* 即可调试 

## 2. 缩小动态库突击大小的方法
* `理解`
```
iOS开发，在Xcode调试程序时，分为两种方式，Debug和Release，在Target的Setting中相信大家应该看到很多选项都分为Debug和Release，方便我们分别设置，满足调试和发布的不同需求。
Release是发行版本,比Debug版本有一些优化，文件比Debug文件小 Debug是调试版本，Debug和Release调用两个不同的底层库。通俗点讲，我们开发者自己内部真机或模拟器调试时，使用Debug模式就好，等到想要发布时，也就是说需要大众客户使用时，需要build Release版本，具体区别如下：
1、Debug是调试版本，包括的程序信息更多
2、只有Debug版的程序才能设置断点、单步执行、使用TRACE/ASSERT等调试输出语句
3、Release不包含任何调试信息，所以体积小、运行速度快
```
* `设置方法`
```
调试程序时，生成（Build）或运行Debug或是Release版本的方法？
Xcode左上角，点中项目名称-Edit Scheme，或是菜单栏-Product-Scheme-Edit Scheme 

当你这里设置Debug时，你build/Run后就是debug版本，相应的，修改成Release模式，出来的就是release版本，这里可以很方便切换
```