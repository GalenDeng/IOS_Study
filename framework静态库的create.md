# framework静态库的create (2019.09.17)

1. `introduce`
```
* .a        静态库
* .dylib    动态库
* .framework 既有动态库，也有静态库的类别
* 一般在 apple 上 ， 审核人员不会通过我们第三方制作的动态库，只审核通过静态库，
  所以我们打包的时候一般使用静态库打包
* 真机上生成的 .a / .framework 不能 用于 模拟机的测试，会报错，同理模拟机下生成的   .a / .framework 不能用于真机，一般情况下，我们需要合并两平台下的 .a / .framework 才能适配在两平台上使用  
```
2. `静态 framework 生成方式`
* [静态framework_to_create](https://www.jianshu.com/p/c2db70f861d6)
```
* Cocoa Touch Framework
* drag source file to compile file
* 更改配置
        Dead Code Stripping  =>  NO
        Link With Standard Libraries => NO -> 避免重复链接
        Mach-O Type => Static Library
* set Headers
* 在项目生成的 XXX.h文件中引入公开的头文件
* 打包 （ Generic IOS device / simulator ）

* 合并真机framework和模拟机framework
cd 到Products目录下，
输入合并语句(注意空格)
lipo -create XXX/Products/Debug-iphonesimulator/libTestA.a XXX/Products/Debug-iphoneos/libTestA.a -output libTestA.a

注意事项：1、framework 在某些情况下出现error，此时需要在该工程中 other linker flags添加两个参数 -ObjC -all_load。（未测试，等碰到问题再补充）
```
3. `.a staticlib create`
```
创建工程时，选择Cocoa Touch Static Library,其余步骤与创建.framework类似
```
