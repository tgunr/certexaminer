//
//  PrefsWindowController.h
//  CertExaminer
//
//  Created by Dave Carlton on 08/09/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PrefsWindowController : NSWindowController
{
	NSMutableArray *sourceArray;
	NSUserDefaultsController *defaultsController;

	NSTableView *sourcesTableView;
	NSButton *addSourceButton;
	NSButton *removeSourceButton;
	NSButton *smartSerachButton;
}

@property (nonatomic, copy) NSMutableArray *sourceArray;
@property (strong) IBOutlet NSTableView *sourcesTableView;
@property (strong) IBOutlet NSButton *addSourceButton;
@property (strong) IBOutlet NSButton *removeSourceButton;
@property (strong) IBOutlet NSButton *smartSerachButton;
- (IBAction)addButtonClick:(NSButton *)sender;
- (IBAction)removeButtonClick:(NSButton *)sender;
- (IBAction)smartSearchButtonClick:(NSButton *)sender;
@end
