//
//  CertificateViewerAppDelegate.h
//  CertificateViewer
//
//  Created by Dave Carlton on 08/03/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CertificateViewerAppDelegate : NSObject <NSApplicationDelegate> {
	NSWindow *_window;
}

@property (strong) IBOutlet NSWindow *window;

@end
