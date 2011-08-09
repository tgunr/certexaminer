//
//  CertDocument.h
//  CertExaminer
//
//  Created by Dave Carlton on 08/01/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Certificate;

@interface CertDocument : NSPersistentDocument {
    Certificate *certificate; 
    NSPathControl *certPathContol;
    NSTextField *certRawText;
    NSDictionaryController *certDictionaryController;
}
@property (strong) IBOutlet NSDictionaryController *certDictionaryController;
@property (strong) IBOutlet NSPathControl *certPathContol;
@property (strong) IBOutlet NSTextField *certRawText;
- (void)pathControlClick;

- (void)examineURL:(NSURL *)aURL;
@end
