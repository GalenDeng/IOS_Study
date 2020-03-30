# pod的使用方式 （2020.03.30）

* [使用cocoapods导入第三方后 报错_OBJC_CLASS_$_XXX](https://www.jianshu.com/p/ed1bc90402f0)
* [使用Cocoapods中跳过pod setup以及pod update和pod install超级慢的解决方法](https://www.jianshu.com/p/e93293d91459?open_source=weibo_search)

* `first`
pod repo remove master
* `second`
```
1.cd ~/.cocoapods/repos
2.git clone https://github.com/CocoaPods/Specs.git
3. 等下载好之后，将repo目录下的Specs 改名为master
4. pod repo
5. 你repo库中的三方都为最新版了,省去了setup以及update漫长的等待过程
```
* `third`
```
* pod install --verbose --no-repo-update
或者
* pod install --no-repo-update
这样安装三方库的速度会有很大的提高
```