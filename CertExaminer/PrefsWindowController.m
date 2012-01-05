//
//  PrefsWindowController.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/09/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "PrefsWindowController.h"
#import "CertExaminer.h"

@implementation PrefsWindowController
@synthesize sourceArray;
@synthesize sourcesTableView;
@synthesize addSourceButton;
@synthesize removeSourceButton;
@synthesize smartSerachButton;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
		sourceArray = [NSMutableArray arrayWithCapacity:1];
		defaultsController = [[CertExaminer sharedCertExaminer] userDefaultsController];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
	NSArray *paths = [[defaultsController values]  valueForKey:@"sourcePaths"];
	[sourceArray addObjectsFromArray: paths];
}

- (IBAction)addButtonClick:(NSButton *)sender
{
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	[panel setCanChooseDirectories: YES];
	[panel setResolvesAliases: YES];
	[panel setAllowsMultipleSelection: YES];
	[panel setAllowedFileTypes:[NSArray arrayWithObjects:@"pem", @"crt", @"p12", nil]];
	// This method displays the panel and returns immediately.
	// The completion handler is called when the user selects an
	// item or cancels the panel.
	[panel beginWithCompletionHandler:^(NSInteger result){
		if (result == NSFileHandlingPanelOKButton) {
			for (id aUrl in [panel URLs] ) {
				NSURL *sourceUrl = nil;
				if ( [aUrl isFileReferenceURL] ) {
					sourceUrl = [aUrl URLByDeletingLastPathComponent];
				} else
					sourceUrl = [aUrl copy];
				if ( ! [sourceArray containsObject:sourceUrl] ) {
					[sourceArray addObject:[sourceUrl path]];
					[[defaultsController values] setObject:sourceArray forKey:@"sourcePaths"];
				}
			}
			[sourcesTableView reloadData];
		}
	}];
}

- (IBAction)removeButtonClick:(NSButton *)sender {
}

- (IBAction)smartSearchButtonClick:(NSButton *)sender {
}

#pragma mark TableView Delegate Methods

#pragma mark TableView Datasource Methods
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [sourceArray count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	NSString *path = [sourceArray objectAtIndex:rowIndex];
	return path;
}
@end
