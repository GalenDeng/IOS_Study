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

注意事项：1、framework 在某些情况下出现error，此时需要在该工程中 other linker flags添加两个参数 -ObjC -all_load （未测试，等碰到问题再补充）
```
3. `.a staticlib create`
```
创建工程时，选择Cocoa Touch Static Library,其余步骤与创建.framework类似
```

4. `真机和模拟器的CPU架构区别`
```
* 真机的架构为 : armv7 armv7s arm64 arm64e
* 模拟器的架构 : i386 x86_64
* 所以生成不同平台下的framework的时候, Architectures 和 Valid Architectures   要相应修改 
* 我们可以通过 lipo -info  xxx.framework/xxx  来查看该 framework 支持哪些架  
  构的CPU
```

5. `framework中需要的资源通过bundle的方式打包 - 导入主工程使用`
```
* 有时候framework中需要使用某些资源，但是我们在framework中使用 [NSBundle    mainBundle] 得到的是主工程的Bundle，而不会得到 framework 中的 Bundle,所以，
我们需要把framework需要使用到的资源，通过bundle的方式打包，放置在主工程的 Copy Bundle Resources,来使用

* framework中使用Bundle的具体方式:
  NSString *pathString1=[[NSBundle mainBundle]pathForResource:@"bundleName" ofType:@"bundle"];
  NSBundle *resourceBundle=[NSBundle bundleWithPath:pathString1];
  NSString *pathString=[resourceBundle pathForResource:@"plistName" ofType:@"plist"];
  NSDictionary *sources=[[NSDictionary alloc]initWithContentsOfFile:pathString];
```

6. `framework的使用方式`
```
* 主工程中包含这个 xxx.framework 
* build Settings -> Link Binary With Libraries -> add this xxx.framework
```
