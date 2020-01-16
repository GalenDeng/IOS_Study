//
//  ViewController.m
//  BlueDemo
//
//  Created by admin on 2020/1/7.
//  Copyright © 2020 com.jolimark.www. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface ViewController ()
//@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UITextView *nameField;
@property (nonatomic, strong) CBCentralManager *CentralManager;
@property (nonatomic, strong) CBPeripheral *peripheral;
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;
@property (nonatomic, copy) NSData *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CentralManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil options:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

//  发送数据
- (IBAction)writeBle:(id)sender {
    //self.nameField.text = @"galen";
    if(self.nameField.text.length < 1) {
        NSLog(@"请填入要发送的数据");
        [SVProgressHUD setMinimumDismissTimeInterval:0.5];
        [SVProgressHUD showSuccessWithStatus:@"请填入要发送的数据"];
        return;
    }
    self.data = [self.nameField.text dataUsingEncoding:
                CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    [self writeChar:self.data];
    NSLog(@"write");
}

// 断开连接
- (IBAction)disConnectBle:(id)sender {
    [self.CentralManager cancelPeripheralConnection:self.peripheral];
    NSLog(@"disConnected");
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showSuccessWithStatus:@"断开蓝牙连接"];
}

// 连接蓝牙设备
- (IBAction)connectBle:(id)sender {
    //[self.CentralManager connectPeripheral:self.peripheral options:nil];
    [self.CentralManager scanForPeripheralsWithServices:nil options:nil];
    NSLog(@"tryConnected");
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showSuccessWithStatus:@"搜索连接蓝牙设备"];
    
}


// 发现外设后回调
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    // @"FP-625K_12345678TT"
    if ( [ peripheral.name isEqualToString:@"FP-625K-98765432AA" ]) {
        NSLog(@"Discovered %@", peripheral.name);
       self.peripheral = peripheral;
       [self.CentralManager stopScan];  // stop search
       [self.CentralManager connectPeripheral:peripheral options:nil];  // 建立连接
        
    }
    

}

// 查找服务
- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    
    NSLog(@"Peripheral connected");
    [NSThread sleepForTimeInterval:3];
    self.peripheral.delegate = self;
    [self.peripheral discoverServices:nil];  // 查找外设服务
}

// 查找到服务后的回调
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error {
    
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@", service);
        if ([service.UUID.UUIDString isEqualToString:@"FF00"]) {
            // 查找特征值
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

// 查找特征值的回调
- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic);
        // justify whether have write characteristic property or not
        if (characteristic.properties & CBCharacteristicPropertyWrite) {

            _writeCharacteristic = characteristic;
        }
    }
}


#pragma mark 写数据
-(void)writeChar:(NSData *)nsData
{
    //Byte tmpData[] = {27,74,255};
    /*NSData *data  = [NSData dataWithBytes:tmpData
                        length:sizeof(tmpData)];*/
    //回调didWriteValueForCharacteristic
    [self.peripheral writeValue:nsData
              forCharacteristic:_writeCharacteristic
                           type:CBCharacteristicWriteWithResponse];
}


- (void)peripheral:(CBPeripheral *)peripheral
didWriteValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error localizedDescription]);
    }
    NSLog(@"Write characteristic value successfully");
}



- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    //NSLog(@"蓝牙状态改变");
    //[self.CentralManager scanForPeripheralsWithServices:nil options:nil];
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
             NSLog(@"PoweredOn");            break;
        default:
            NSLog(@"Central Manager did change state");
            break;
    }
}


@end
