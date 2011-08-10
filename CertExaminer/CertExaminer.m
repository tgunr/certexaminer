//
//  CertExaminer.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/03/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "CertExaminer.h"
#import "PrefsWindowController.h"

@implementation CertExaminer

@synthesize window;
@synthesize certsTableView;
@synthesize certFolder;
@synthesize files;
@synthesize infoToolBarItem;
@synthesize addToolBarItem;
@synthesize removeToolBarItem;
@synthesize quickLookToolBarItem;
@synthesize findToolBarItem;
@synthesize prefsToolBarItem;
@synthesize compareToolBarItem;

@synthesize prefsWindow;
@synthesize prefsWindowController;

-(void)awakeFromNib
{
    [certFolder setURL:[NSURL URLWithString:@"file:///etc/certificates"]];
	NSFileManager *fm = [NSFileManager defaultManager];
	BOOL isFolder;
	[fm fileExistsAtPath:[[certFolder URL] path] isDirectory:&isFolder];
	if (isFolder) {
		NSArray *properties = [NSArray arrayWithObjects:
							   NSURLNameKey, 
							   nil];
		NSError *errResult;
		files = [fm contentsOfDirectoryAtURL:[certFolder URL] 
				  includingPropertiesForKeys:properties 
									 options:NSDirectoryEnumerationSkipsHiddenFiles
									   error:&errResult];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

#pragma mark - Table View Delegate
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [files count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	NSString *fileName = [[files objectAtIndex:rowIndex] path];
	return fileName;
}
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	
}

- (IBAction)infoToolBarItemClick:(NSToolbarItem *)sender {
}

- (IBAction)addToolBarItemClick:(NSToolbarItem *)sender {
}

- (IBAction)removeToolBarItemClick:(NSToolbarItem *)sender {
}

- (IBAction)quickLookToolBarItemClick:(NSToolbarItem *)sender {
}

- (IBAction)findToolBarItemClick:(NSToolbarItem *)sender {
}

- (IBAction)prefsToolBarItemClick:(NSToolbarItem *)sender {
	NSNib *nib = [[NSNib alloc] initWithNibNamed:@"Preferences" bundle:nil];
	
    // At this pint, our outlets to inside this nib will be properly setup. It is important to note
    // that they will get overwritten when this is called again!
    // In general, it is good practice to use a unique controller object for each nib you load.
    // You will normally pass that controller as the 'owner'. For simplicity purposes we are passing
    // in this object as the owner.
    //
    [nib instantiateNibWithOwner:self topLevelObjects:nil];
    [prefsWindow makeKeyAndOrderFront:nil];
}

- (IBAction)compare:(NSToolbarItem *)sender {
}
@end
