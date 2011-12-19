
/*
     File: AppDelegate.m
 Abstract: Application delegate to add the split view controller's view to the window.
 
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "AppDelegate.h"
#import "RootViewController.h"

@implementation AppDelegate

@synthesize window, splitViewController;

- (void)normalConnect
{
	NSError *error = nil;
	
	NSString *host = @"192.168.11.122";
    //	NSString *host = @"deusty.com";
	
	if (![asyncSocket connectToHost:host onPort:11999 error:&error])
	{
		NSLog(@"Error connecting: %@", error);
	}
    
	// You can also specify an optional connect timeout.
	
    //	if (![asyncSocket connectToHost:host onPort:80 withTimeout:5.0 error:&error])
    //	{
    //		DDLogError(@"Error connecting: %@", error);
    //	}
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"Oh~Yes!");
}

- (void)secureConnect
{
	NSError *error = nil;
	if (![asyncSocket connectToHost:@"www.paypal.com" onPort:443 error:&error])
	{
		NSLog(@"Error connecting: %@", error);
	}
}

-(void) onTimer {

    NSData *data = [[NSData alloc] initWithData:[@"1[/TCP]" dataUsingEncoding:NSASCIIStringEncoding]];

    [asyncSocket writeData:data withTimeout:10 tag:1];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
	
	asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
	
	[self normalConnect];
    [splitViewController setValue:[NSNumber numberWithFloat:260.0] forKey:@"_masterColumnWidth"];
    [window addSubview:splitViewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	NSLog(@"socket:%p didConnectToHost:%@ port:%hu", sock, host, port);
	
    //	DDLogInfo(@"localHost :%@ port:%hu", [sock localHost], [sock localPort]);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:600
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
	/*
	if (port == 443)
	{
		
        #if !TARGET_IPHONE_SIMULATOR
		
		// Backgrounding doesn't seem to be supported on the simulator yet
		
		[sock performBlock:^{
			if ([sock enableBackgroundingOnSocketWithCaveat])
				NSLog(@"Enabled backgrounding on socket");
			else
				NSLog(@"Enabling backgrounding failed!");
		}];
		
        #endif
		
		// Configure SSL/TLS settings
		NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithCapacity:3];
		
		// If you simply want to ensure that the remote host's certificate is valid,
		// then you can use an empty dictionary.
		
		// If you know the name of the remote host, then you should specify the name here.
		// 
		// NOTE:
		// You should understand the security implications if you do not specify the peer name.
		// Please see the documentation for the startTLS method in GCDAsyncSocket.h for a full discussion.
		
		[settings setObject:@"www.paypal.com"
					 forKey:(NSString *)kCFStreamSSLPeerName];
		
		// To connect to a test server, with a self-signed certificate, use settings similar to this:
		
        //	// Allow expired certificates
        //	[settings setObject:[NSNumber numberWithBool:YES]
        //				 forKey:(NSString *)kCFStreamSSLAllowsExpiredCertificates];
        //	
        //	// Allow self-signed certificates
        //	[settings setObject:[NSNumber numberWithBool:YES]
        //				 forKey:(NSString *)kCFStreamSSLAllowsAnyRoot];
        //	
        //	// In fact, don't even validate the certificate chain
        //	[settings setObject:[NSNumber numberWithBool:NO]
        //				 forKey:(NSString *)kCFStreamSSLValidatesCertificateChain];
		
		NSLog(@"Starting TLS with settings:\n%@", settings);
		
		[sock startTLS:settings];
		
		// You can also pass nil to the startTLS method, which is the same as passing an empty dictionary.
		// Again, you should understand the security implications of doing so.
		// Please see the documentation for the startTLS method in GCDAsyncSocket.h for a full discussion.
	}
    */
}

- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag
                 elapsed:(NSTimeInterval)elapsed
               bytesDone:(NSUInteger)length;
{
    [timer invalidate];
    return -1;
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock
{
	NSLog(@"socketDidSecure:%p", sock);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"socketDidDisconnect:%p withError: %@", sock, err);
}

- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end
