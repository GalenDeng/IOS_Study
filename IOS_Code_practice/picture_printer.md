# picture_printer (2019.03.05)

* `ios屏幕的截图`
```
    #pragma mark ----   convertViewToImage
    - (UIImage *)convertViewToImage{
        if (iOS7) {
            UIGraphicsBeginImageContextWithOptions(asycImageView.bounds.size, YES, 1);
            [asycImageView drawViewHierarchyInRect:asycImageView.bounds afterScreenUpdates:YES];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }else
        {
            UIGraphicsBeginImageContextWithOptions(self.view.frame.size, YES, 0.0);
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            return image;
        }
        return nil;
    }
```
* `imageNamed` 和 `imageWithContentsOfFile`
```
缓存加载方式(imageNamed) :

使用imageNamed这个方法生成的UIImage对象,会在应用的bundle中寻找图片,如果找到则Cache到系统缓存中,作为内存的cache,而程序员是无法操作cache的,只能由系统自动处理,如果我们需要重复加载一张图片,那这无疑是一种很好的方式,因为系统能很快的从内存的cache找到这张图片,但是试想,如果加载很多很大的图片的时候,内存消耗过大的时候,就会会强制释放内存，即会遇到内存警告(memory warnings).由于在iOS系统中释放图片的内存比较麻烦,所以冲易产生内存泄露。

非缓存加载方式 (imageWithContentsOfFile) :

相比上面的imageNamed这个方法要写的代码多了几行,使用imageWithContentsOfFile的方式加载的图片，图片会被系统以数据的方式进行加载.返回的对象不会保存在缓存中，一旦对象销毁就会释放内存，所以一般不会因为加载图片的方法遇到内存问题.

总结下：

何时用imageNamed ： 图片资源反复使用到，如按钮背景图片的蓝色背景，这些图片要经常用到，而且占用内存少

不能用 imageNamed ： 图片资源较大，加载到内存后，比较耗费内存资源 ，图片一般只使用一次

最好是通过直接读取文件路径[UIImage imageWithContentsOfFile]解决掉这个问题

NSString *path =   [[NSBundle mainBundle]pathForResource:filename ofType:@"png"];
[UIImage imageWithContentsOfFile:path]
```
```
// 压缩质量，图片大小会变
            UIImage *img = [self getPrintImage];
            NSData *imageData = [self imageWithImage:img scaledToSize:img.size ];
            UIImage *image1 = [UIImage imageWithData: imageData];
            //UIImage *img = [self convertViewToImage];
            //UIImage *img1 = [UIImage imageWithData:data1];
            data = [SINGLETONBLE transformImageToData:image1
                                                 type:SINGLETONBLE.printerType];


- (NSData *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
/*    NSString * path = [NSString stringWithFormat:@"%@/Documents/cutSome.jpg",NSHomeDirectory()];*/
    NSData * imagedata = UIImageJPEGRepresentation(newImage, 1);
    
  /*  if( [imagedata writeToFile:path atomically:YES]){
        NSLog(@"保存成功%@",path);
    }*/
    
    return imagedata;
    
    
}
```