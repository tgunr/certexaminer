//
//  CertExaminer.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/03/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "CertExaminer.h"

@implementation CertExaminer

@synthesize window;
@synthesize certsTableView;
@synthesize certFolder;
@synthesize files;

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
@end
