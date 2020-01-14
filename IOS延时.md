# IOS延时  （2020.1.3）

1. `阻塞延时`
```
*  [NSThread sleepForTimeInterval:0.2]; // 200ms
   note : sleepForTimeInterval 是阻塞延时， 单位是 秒级计算
```
2. `afterDelay`
```
* [self performSelector:@selector(printDataWithIndex:) withObject:[NSNumber numberWithInteger:++self.printIndex] afterDelay:0.2];

* - (void)printDataWithIndex:(NSNumber *)objIndex { }
```