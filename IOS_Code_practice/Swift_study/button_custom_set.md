# button create (2019.06.13)
```
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "设备列表"
        viewModel.coreBluetoothCentral.delegate = self
        
        // 创建一个常规的button
        let button = UIButton(type:.custom)
        button.frame = CGRect(x:50, y:300, width:100, height:100)
        button.setTitle("发送数据", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        //无参数点击事件
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        //带button参数传递
        //button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }

        //无参数点击事件
    @objc func buttonClick(){
        print("点击了button")
        let bytes:[UInt8] = [27,74,255]
        let data = NSData(bytes: bytes, length: bytes.count)
        print(data)
        viewModel.peripherals[0].writeValue(data as Data, for: viewModel.serviceCharacteristics[0], type: CBCharacteristicWriteType.withResponse)
    }

      /*  @objc func buttonClick(button:UIButton ){
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.setTitle("Selected", for: .normal)
            let bytes:[UInt8] = [27,74,255]
            let data = NSData(bytes: bytes, length: bytes.count)
            print(data)
            self.peripherals[0].writeValue(data as Data, for: characteristics[0], type: CBCharacteristicWriteType.withResponse)
        }else{
            button.setTitle("NoSelected", for: .normal)
        }
    }
 
    */
```