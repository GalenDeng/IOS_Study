# c++知识点 (2019/03/11)

* `复制时建议用的函数`
* memcpy(&src[0],dest,[data length]);

```
    vector<uint8_t> src([middleData length]);       // 容器，建议给出容量初始大小
    Byte  *testByte = (Byte *)[middleData bytes];   // NSDATA 转 Byte
    //printf("testByte = %d\n",[data1 length]);
    memcpy(&src[0],testByte,[middleData length]);   // copy data to testByte point
    //printf("src = %d\n",src.size());

    std::ostringstream oss;                         // 输出流
    // Delete the blanks in the image
    bool state =  trim_esc_data(src,oss);
    //std::clog<<"oss = "<< oss.tellp()<< std::endl;// clog 用作打印，且在 .mm 中使用 clog等函数，需要添加再其前面添加命名空间std，即 std::clog    
    
    NSData *data = [[NSData alloc] initWithBytes:(oss.str().c_str()) length:oss.tellp()];
```