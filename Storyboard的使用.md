#  Storyboard的使用 （2019/05/07）

1. `作用`
```
* 相对于XIB,Storyboard可以减少代码量
* 为UIViewController子类对象构建用户界面，并创建相应的对象
* 可以将各子类对象连接起来，设置相应的显示流程和显示模式 【为多个视图控制器设置相互间的关系】
```
2. `设置步骤`
```
* 1. new a  storyboard file
* 2. drag a Navigation Controller 
* 3. delete a  redundant view
* 4. drag a View Controller
* 5. drag navigation Controller 的 root view controller 与 View Controller 连接
* 6. View Controller 的  custom class select ViewController(根据真实情况填选class)
* 7. navigation Controller 勾选 is initial View Controller [即添加入口]，不然 build 的时候会报错 ：
  Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set?
* 8. select project -> General -> Main interface -> select this  xxx.storyboard 
* build and will be successful  
```