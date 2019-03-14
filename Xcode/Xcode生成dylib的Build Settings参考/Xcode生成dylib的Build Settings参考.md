# Xcode生成dylib的Build Settings参考 (2019/03/12)
1. Xcode 左上角选择你想要的Scheme -> Edit schme -> Duplicate Scheme -> 左上角修改要duplicate的schme的名字 -> close
2. select project -> targets 那里的左侧修改要生成的dylib的名字
3. select the target that we want to repair -> click Build Settings
4. Architectures -> arm64、armv7、armv7s -> select the architectures that we want to generate
5. Build Active Architecture Only -> select NO -> in order to make sure that can generate all the architectures
6. Valid Architectures -> arm64、armv7、armv7s
7. Linking -> Dynamic Library install Name -> @executable_path/Frameworks/libWirelessdySDK.dylib
8. Mach-O Type -> Dynamic Library ; Other Linker Flags -> -ObjC  -lxml2  $(inherited)  -dynamiclib -Wl -headerpad_max_install_names
9. Packaging -> Executable Extension -> dylib ; Executable Prefix -> lib ; Product Name -> 你自定义的名字 ; Public Headers Folder Path -> include
10. Search Paths -> Header Search Paths -> ${SDKROOT}/usr/include/libxml2
11. 生成 dylib 动态链接库后，记得 cd 到 dylib's dir , execute the operation : otool -L XXX.dylib , in order to see the install path_name of the dylib whether is @executable_path/Frameworks/libxxx.dylib or not,if that's no, you must to execute :
install_name_tool -id @executable_path/Frameworks/libxxx.dylib  xxx.dylib

# 在引入dylib的project中，we must to executable these operations:
1. 将 libxxx.dylib（已经设置好install_name） 文件 copy the porject , 和 xxx、xxx.xcodeproj、xxxTests 同一个目录下
2. project -> Build Settings -> Search Runpath -> Runpath Search Paths -> set : @executable_path/Frameworks 
3. Build Phases -> Link Binary With Libraries -> import the libxxx.dylib to the position
(sometimes we may import the  libxxx.dylib to Embed Libraries too )
4. we may need to set the header path by User Header Search Paths and so on