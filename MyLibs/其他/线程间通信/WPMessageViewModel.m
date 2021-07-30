//
//  WPMessageViewModel.m
//  MyLibs
//
//  Created by Joey on 2021/7/30.
//

#import "WPMessageViewModel.h"

@interface WPMessageViewModel()<NSMachPortDelegate>
{
    
    NSPort *remotePort;
    NSPort *myPort;
}

@end

@implementation WPMessageViewModel
- (void)passMessage:(NSMachPort *)port
{
    @autoreleasepool
    {
        remotePort = port;
        [[NSThread currentThread] setName:@"MyWorkerClassThread"];
        myPort = [NSPort port];
        myPort.delegate = self;
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        [self sendPortMessage];
        [[NSRunLoop currentRunLoop] run];
    }
}
 
- (void)sendPortMessage
{
    NSMutableArray *array  = [[NSMutableArray alloc] initWithArray:@[@"1",@"2"]];
    [remotePort sendBeforeDate:[NSDate date] msgid:100 components:array
    from:myPort reserved:0];
}
 
- (void)handlePortMessage:(NSPortMessage *)message
{
    NSLog(@"接收到父线程的消息...\n");
}

@end
