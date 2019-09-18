# NSBundle mainBundle 在 framework等staticlib的使用注意 (2019.09.18)

1. `framework / .a 静态库中使用 NSBundle mainBundle`
```
* 在静态库中使用 NSBundle mainBundle 的时候，这个时候我们获取的是另一个主工程的bundle路径(该主工程使用了这些静态库的内容)，而无法获取到静态库的bundle路径
```