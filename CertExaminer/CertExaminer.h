//
//  CertExaminer.h
//  CertExaminer
//
//  Created by Dave Carlton on 08/03/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CertExaminer : NSObject <NSApplicationDelegate>
{
	NSWindow *window;	
	NSTableView *certsTableView;
	NSPathControl *certFolder;
	NSArray *files;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSPathControl *certFolder;
@property (strong) IBOutlet NSTableView *certsTableView;
@property (nonatomic, copy) NSArray *files;
- (IBAction)certFileSelected:(id)sender;

@end
