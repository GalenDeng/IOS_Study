# 支持bitcode的framework配置方式 （2019.09.20）

1. `支持bitcode的设置`
```
* Enable Bitcode : No
* Other linker flags : add -fembed-bitcode
* Other c flags : add -fembed-bitcode
* Other c++ flags : add -fembed-bitcode
```


2. `判断该静态库是否支持bitcode`
```
* otool -arch armv7 -l xx.a | grep __bitcode
* otool -arch armv7 -l xx.framework | grep __bitcode
```
