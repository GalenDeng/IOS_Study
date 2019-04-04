# objective-C知识点 (2019/04/02)

1. `格式符%p`
```
* 格式控制符“%p”中的p是pointer（指针）的缩写
* 指针的值都是一个表示地址空间中某个存储器单元的整数
* 对于%p一般以十六进制整数方式输出指针的值，附加前缀0x
* NSDate *now = [NSDate date]; NSLog(@"This NSDate object lives at %p",now);
```