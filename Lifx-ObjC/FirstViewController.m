//
//  FirstViewController.m
//  Lifx-ObjC
//
//  Created by Jordan Zucker on 2/1/14.
//  Copyright (c) 2014 Jordan Zucker. All rights reserved.
//

#import "FirstViewController.h"
#import <GCDAsyncUdpSocket.h>

typedef struct
{
    UInt16 size;              // LE
    UInt16 protocol;
    UInt32 reserved1;         // Always 0x0000
    Byte   target_mac_address[6];
    UInt16 reserved2;         // Always 0x00
    Byte   site[6];           // MAC address of gateway PAN controller bulb
    UInt16 reserved3;         // Always 0x00
    UInt64 timestamp;
    UInt16 packet_type;       // LE
    UInt16 reserved4;         // Always 0x0000
    
    void *payload;           // Documented below per packet type
} packet;

packet CreatePacket(){
    packet Packet;
    Packet.reserved1 = 0x0000;
    Packet.reserved2 = 0x00;
    Packet.reserved3 = 0x00;
    Packet.reserved4 = 0x0000;
    return Packet;
}

@interface FirstViewController () <GCDAsyncUdpSocketDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //GCDAsyncUdpSocket *socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];

//    NSError *err = nil;
//    if (![socket connectToHost:@"deusty.com" onPort:80 error:&err]) // Asynchronous!
//    {
//        // If there was an error, it's likely something like "already connected" or "no delegate set"
//        NSLog(@"I goofed: %@", err);
//    }
//    NSError *err = nil;
//    uint16_t port = 56700;
//    //NSString *interface = @"0.0.0.0";
//    //if (![socket bindToPort:port interface:interface error:&err])
//    if (![socket bindToPort:port error:&err])
//    {
//        
//        NSLog(@"I goofed: %@", err);
//    }
//    sleep(20);
//    //NSString *command = @"0x02";
//    //static const unsigned char command = 0x02;
//    //const char *buf = [command UTF8String];
//    //NSData *data = [command dataUsingEncoding:NSStringEncodingConversionAllowLossy];
//    //NSMutableData *data = [NSMutableData data];
//    packet discovery = CreatePacket();
//    discovery.protocol = 0x02;
//    
//    NSData *data = [NSData dataWithBytes:&discovery length:sizeof(discovery)];
//    NSLog(@"data is %@", data);
//    [socket sendData:data toHost:@"255.255.255.255" port:port withTimeout:10 tag:1];
    
}

-(NSData *) HexByteDataFromString:(NSString *) str
{
    NSMutableData *data= [[NSMutableData alloc]init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    for (int i = 0; i < ([str length] / 2); i++)
    {
        byte_chars[0] = [str characterAtIndex:i*2];
        byte_chars[1] = [str characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    return data;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
    NSLog(@"didConnect");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error
{
    NSLog(@"didNotConnect");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"didSendDataWithTag");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"didNotSendDataWithTag");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    NSLog(@"didReceiveData");
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    NSLog(@"didClose");
    NSLog(@"with error: %@", error);
}

@end
