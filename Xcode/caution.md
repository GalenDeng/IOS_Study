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