## 调用动态库dylib    （2019.1.25）

* `生成dylib(Xcode平台)的工程，可以通过 CMakeLists.txt来实现`
* 除了CMakeLists ,有时候要加上 toolchaiin，为了方便，还可以编写一个批文件（shell脚本）来run.
* 这里的脚本和toochain在同一目录下（不一定要在同一目录下，脚本里的定义的路径来决定的）
* [运行脚本](https://github.com/GalenDeng/IOS_Study/blob/master/Xcode/dylib%E5%BA%93%E7%9A%84%E7%94%9F%E6%88%90%E4%B8%8E%E8%B0%83%E7%94%A8/configture_ios)
* [toolchain](https://github.com/GalenDeng/IOS_Study/blob/master/Xcode/dylib%E5%BA%93%E7%9A%84%E7%94%9F%E6%88%90%E4%B8%8E%E8%B0%83%E7%94%A8/toolchain_ios64.cmake)

* `关键 command`
```
// otool -L xxx.dylib : 查看 xxx.dylib 动态库的install 目录及依赖
* admindeMacBook-Pro:Debug-iphoneos admin$ otool -L libfreeimage.dylib
libfreeimage.dylib (architecture armv7):
	@executable_path/Frameworks/libfreeimage.dylib (compatibility version 0.0.0, current version 0.0.0)
	/usr/lib/libc++.1.dylib (compatibility version 1.0.0, current version 400.9.1)
	/usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1252.0.0)

// install_name_tool -id @executable_path/../Frameworks/libabc.0.dylib libabc.0.dylib 
// 上一行命令是改变 libabc.0.dylib 的安装目录
// 一般我们的APP要使用这些库的话，必须把这些库放进内置的Frameworks里面才行，我们可以通过上面的命令
// 使到该库的install path 变为 相对路径，再在 Xcode上的build Setting 修改参数，即可实现这功能
```
* `调用dylib库的Xcode build Setting 关键点`
```
1. copy 相应的 xxx.dylib在本项目目录下
2. 使用 otool -L xxx.dylib 命令查看该动态库的依赖及install path 是否改为相对path
3. Xcode -> 工程设置 -> Build Phases -> Link Binary With Libraries -> add xxx.dylib (Require)
4.  Xcode -> 工程设置 ->  General -> Embedded Binaries -> add xxx.dylib
5.  Xcode -> 工程设置 ->  Build Setting -> Libary Search  Paths -> add 复制到该工程目录下的 xxx.dylib的path
6.  User Header Search Paths -> add 你这个动态库 dylib 需要的头文件的 Path location.
*   引用头文件的时候要使用 #import “xxx.h” 的 form
7.  Xcode -> 工程设置 ->  Build Setting -> Runpath Search Paths -> add @executable_path/Frameworks
```