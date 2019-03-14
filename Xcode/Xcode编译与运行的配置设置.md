# Xcode编译与运行的配置设置 (2019.03.05)
* `IOS应用编译在其他不同IOS版本的系统上的配置`
```
* 1. 要能安装在该IOS系统上，则Xcode必须具有该版本的SDK,若没，进行以下操作添加（or update Xcode）
     * 下载相关版本的 IOS真机版本测试包 -> 解压
     * 把解压包放置在 /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport
* 2. click Xcode -> click 工程 -> Build Settings -> search code sign -> 修改 Code Signing Identty 的 Any iOS SDK 为 iOS Developer
* 3. click General -> automatically manage signing -> select GalenDeng(我的ID)
* 4. 有时候我们需要修改 Bundle Identifier 的名字
```