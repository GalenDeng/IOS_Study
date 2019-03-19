# file_operation(2019.03.19)

* `1. NSData 写入文件`
```
           /************************** 数据保存到文件的操作  ********************************************
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            // remove the existed file
            NSString * path = [NSString stringWithFormat:@"%@/Documents/nsdata.txt",NSHomeDirectory()];
            if ([fileManager removeItemAtPath:path error:NULL]) {
                NSLog(@"Removed successfully");
            }
            // data保存到文件
            if( [data writeToFile:path atomically:YES]){
                NSLog(@"保存成功 : %@",path);
            }

            ******************************************************************************************/
```
* * `文件取出方式`
```
1. open xcode -> Windows -> Device and Simulators
2. left: click the corresponding dedvice(ipad or iphone) 
3. right : click the corresponding app -> under set[下面的设置] -> Download Cointainer to download the file to mac -> 
4. .xcappdata文件 -> show package contents -> view the data file
```