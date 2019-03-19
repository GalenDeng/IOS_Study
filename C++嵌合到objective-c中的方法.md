# C++ 嵌合到 Objective-C 中的方法 (2019/03/11)

* `.m 和 .mm 的区别`
```
* .m 文件可以编写 Object-C / C 的 code
* .mm 文件可以编写 Object-C / C / C++ 的 code
```
* `运用场景描述及解决方式`
```
* 我想把 c++ code 实现的功能可以在.m 文件中运行实现，可是 .m 只支持 Object-C / C 的 code，
  这个时候我们的实现方式应该是怎样？ 
* 解决方式 :
1. 通过Xcode 生成 .hpp .cpp 文件，函数功能在 .cpp 中编写，然后生成 .h .mm 文件
2. .h 文件就包括 object-c/c的头文件，而 .mm 中实现 .cpp 的功能， .cpp 需要的头文件可以放 .hpp ,
   然后在 .mm 中 #import 这个 .hpp ,或者直接把 .cpp 需要的头文件在 .mm 中直接 引用
3. 把 .h , .cpp , .h , .mm 文件在 Xcode 中通过设置 Build Settings 来生成 .dylib 动态链接库
4. 在另一个工程里面，通过 link 该 dylib 来达到 使用 .cpp 实现的函数功能

* 注意，我们不能把  .h , .cpp , .h , .mm 文件生成静态链接库，因为在引用了该静态链接库的 .m 工程里，当我们编译的时候，link 会报错，因为我们需要包含 c++ 的头文件，而系统在该种配置情况下会报错(若把 .m 文件改成 .mm 就可以link成功，但这种方式耦合度太强，不符合我们的要求)，而若我们生成的是 .dylib 动态链接库，我们在引用这个库的.m工程里,在编译的时候可以直接使用这个动态库的函数功能(因为引用动态链接库的工程在编译的时候，不会再次把 .dylib 动态链接库进行link,而是直接使用)
```
* `new understanding`
```
1. 当我们需要在objc 中嵌入 c++ code , c++ 的代码 分为 .h 、 .cpp 文件，然后在调用 c++ 的函数的 objc 文件中把文件的后缀 .m be replaced to .mm ,so the file can use the c++ func
2. 当我们finish the first step and make it to a static lib(.a), and we are going to use the static lib to the other project, so the project may need to set a option : xcode -> 
Build Settings -> Compiler Sources As to objective-C++ , or not, it may make some issues.
```