//
//  CertDocument.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/01/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "CertDocument.h"
#import "Certificate.h"

#define TESTING

@implementation CertDocument
@synthesize certDictionaryController;
@synthesize certPathContol;
@synthesize certRawText;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        // If an error occurs here, return nil.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"CertDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
//    [self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
    SEL pathControl = @selector(pathControlClick);
    [certPathContol setDoubleAction:pathControl];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}


#pragma mark -
#pragma PathControl

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        if ([files count]) {
            NSString *fileName = [files objectAtIndex:0];
            if ([fileName hasSuffix:@".cer"]) {
                return YES;
            }
            if ([fileName hasSuffix:@".pem"]) {
                return YES;
            }
            if ([fileName hasSuffix:@".key"]) {
                return YES;
            }        
        }
    }
    return NO;
}

- (NSDragOperation)pathControl:(NSPathControl *)pathControl validateDrop:(id < NSDraggingInfo >)info
{    
    if ([self performDragOperation: info])
        return NSDragOperationLink;
    else    
        return NSDragOperationNone;
}

- (void)examineURL:(NSURL *)aURL  {
    [certificate setCertURL:aURL];
    [certPathContol setURL:aURL];
    [certificate examineURL];
    NSString * certType = [certificate type];
    
    [certRawText setStringValue: [certificate fileContent]];
}

- (void)concludeDragOperation:(id < NSDraggingInfo >)sender
{
    certificate = [Certificate new];
    [self examineURL: [certPathContol URL]];
}

- (void)pathControlClick 
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel beginWithCompletionHandler:^(NSInteger result) {
        NSArray *files = [panel URLs];
        if ([files count]) {
            certificate = [Certificate new];
            NSURL *aURL = [files objectAtIndex: 0];
            [self examineURL: aURL];
        }
    }];
}

@end
