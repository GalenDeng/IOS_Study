# byte[] convert to NSData
```
        var orderPrintData: NSData {
            let bytes:[UInt8] = [27,74,255]
            let data = NSData(bytes: bytes, length: bytes.count)
            print(data)
            return data
        }
```