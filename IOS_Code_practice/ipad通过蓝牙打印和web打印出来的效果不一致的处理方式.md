# ipad通过蓝牙打印和web打印出来的效果不一致的处理方式 (2019/03/13)
* 印刷行业的pt = 1 / 72 英寸 ，而 1英寸 = 25.4 mm,但是在 ios 中 ，绝对位置 pt 不一定等于 1/72,这和分辨率，尺寸等有关系，这个时候需要我们对比一下web打印出来的效果和ipad打印出来的效果
* `对比方法`
```
* 使用IOS的绘图功能，画出纸张的大小，用直线表出第一个字符打印的位置，ipad进行蓝牙打印，用直尺量出第一个字符的（x,y)的实际坐标值（mm）
* 通过使用Lodop进行web+usb的打印，也是要画出纸张的矩形大小，用直线画出第一个坐标的位置，打印出来
* 对比用 Ipad 和 Lodop 打印出来的第一个坐标的坐标值，求出他们之间的关系
* 然后在 IOS 的代码中修改系数
* 通过测试，x轴和y轴的系数是 3.55 
* 因为 web 和 printer 的坐标原点有区别，所以有时要在发送数据之前要先发送这三个字节 {0x1B,0x4A,0x24}  即是 \x1B\x4A\x24
```
* `NSData 数据拼接`
```
* 因为 NSData 是不可变对象，一旦进行了赋值就再也不能be changed,so we need to use NSMutableData 
  进行拼接,实现代码如下
```
```
            Byte firstByte[] = {0x1B,0x4A,0x24};
            NSData *firstData = [NSData dataWithBytes:firstByte
                                length:sizeof(firstByte)];
            NSMutableData *mData = [[NSMutableData alloc]initWithData:firstData];
            UIImage *img = [self getPrintImage];
            NSData *secondData = [SINGLETONBLE transformImageToData:img
                                type:SINGLETONBLE.printerType];
            [mData appendData: secondData];
            data = [mData subdataWithRange:NSMakeRange(0, mData.length)];
            WQLogMsg(@"data length is : %ld",
                     [data length]);
```
* `创建图片：包括绘制矩形、直线`
```
#define kXRatio 3.55
#define kYRatio 3.55
- (UIImage *)getPrintImage
{
    CGSize size = CGSizeMake(240*kXRatio, 140*kYRatio);
    NSArray *textArray = @[ @{ @"x": @"42", @"y": @"22", @"text": @"发货人" },
                            @{ @"x": @"140", @"y": @"21", @"text": @"收货人" },
                            @{ @"x": @"42", @"y": @"29", @"text": @"发货电话" },
                            @{ @"x": @"140", @"y": @"28", @"text": @"收货电话" },
                            @{ @"x": @"57", @"y": @"67", @"text": @"现付" },
                            @{ @"x": @"89", @"y": @"67", @"text": @"月结" } ];
    
    UIImage *image = [self.class imageWithColor:[UIColor whiteColor] size:size textArray:textArray];
    return image;
}

// 类方法
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
                  textArray:(NSArray *)textArray
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    for (NSDictionary *dict in textArray) {
        NSString *text = dict[@"text"];
        CGFloat x = [dict[@"x"] floatValue]*kXRatio;
        CGFloat y = [dict[@"y"] floatValue]*kYRatio;
        NSDictionary *attr = @{ NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:13] };
        CGSize textSize = [text sizeWithAttributes:attr];
        [text drawInRect:CGRectMake(x, y, textSize.width, textSize.height) withAttributes:attr];
    }
    
 /************************* 绘制矩形(四条边) + 直线在图形上下文中 ***************************/
 /*    CGContextStrokeRect(context,CGRectMake(0, 0, size.width, size.height));//画方框
    //画线
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(42*kXRatio, 22*kYRatio);//坐标1
    aPoints[1] =CGPointMake(47*kXRatio, 22*kYRatio);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, aPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
 
    
    CGPoint bPoints[2];//坐标点
    bPoints[0] =CGPointMake(42*kXRatio, 22*kYRatio);//坐标1
    bPoints[1] =CGPointMake(42*kXRatio, 26*kYRatio);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(context, bPoints, 2);//添加线
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
*/
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
```
* `FP312K feature`
```
* 要注意x方向，这机应该有自动寻边，你任意放纸它都能定位出左边缘（前提是不超过可打印范围)
* 纸是有穿孔的，而打印机并不知道有没有孔，所以x坐标是从纸边开始算，所以量位置就不要跳过那些孔
```