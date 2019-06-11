# CocoaPods的install及使用_install第三方库 (2019.06.11)
* [参考文档](https://www.cnblogs.com/daguo/p/4097295.html)

* `CocoaPods的install`
```
* sudo gem install cocoapods
```
* `查看第三方库是否可通过 CocoaPods download 且 查看其支持的版本`
```
* pod search AFNetworking(xxx)
```
* `new a Podfile`
```
* 新建的这个Podfile 要和 工程文件.xcodeproj在同一个目录下
* vim Podfile
```
* `Podfile的content`
```
source 'https://github.com/CocoaPods/Specs.git'  // required
platform :ios, '12.1'                       // required
use_frameworks!                             // required

target 'BleSwift' do                        //// required  : BleSwift 为工程文件名
    pod 'MJRefresh', '~> 3.1.15.7'          // the file that want to download
    pod 'DZNEmptyDataSet', '~> 1.8.1'
end
```
* `cd 到 Podfile的目录，execute :  pod install`
* `以后打开项目就用 xxx.xcworkspace 打开，而不是之前的.xcodeproj文件`
* `notice`
```
这里的意思大概是Podfile文件过期，类库有升级，但是Podfile没有更改。$ pod install只会按照Podfile的要求来请求类库，如果类库版本号有变化，那么将获取失败。但是 $ pod update会更新所有的类库，获取最新版本的类库。而且你会发现，如果用了 $ pod update，再用 $ pod install 就成功了。

那你也许会问，什么时候用 $ pod install，什么时候用 $ pod update 呢，我又不知道类库有没有新版本。好吧，那你每次直接用 $ pod update 算了。或者先用 $ pod install，如果不行，再用 $ pod update
```