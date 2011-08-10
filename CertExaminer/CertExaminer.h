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
	NSToolbarItem *infoToolBarItem;
	NSToolbarItem *addToolBarItem;
	NSToolbarItem *removeToolBarItem;
	NSToolbarItem *quickLookToolBarItem;
	NSToolbarItem *findToolBarItem;
	NSToolbarItem *prefsToolBarItem;
	NSToolbarItem *compareToolBarItem;
}

@property (strong) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSPathControl *certFolder;
@property (strong) IBOutlet NSTableView *certsTableView;
@property (nonatomic, copy) NSArray *files;

@property (strong) IBOutlet NSToolbarItem *infoToolBarItem;
@property (strong) IBOutlet NSToolbarItem *addToolBarItem;
@property (strong) IBOutlet NSToolbarItem *removeToolBarItem;
@property (strong) IBOutlet NSToolbarItem *quickLookToolBarItem;
@property (strong) IBOutlet NSToolbarItem *findToolBarItem;
@property (strong) IBOutlet NSToolbarItem *prefsToolBarItem;
@property (strong) IBOutlet NSToolbarItem *compareToolBarItem;

- (IBAction)infoToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)addToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)removeToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)quickLookToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)findToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)prefsToolBarItemClick:(NSToolbarItem *)sender;
- (IBAction)compare:(NSToolbarItem *)sender;

@end
