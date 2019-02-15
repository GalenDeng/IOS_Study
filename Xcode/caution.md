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