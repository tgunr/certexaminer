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
@synthesize userDefaultsController;

static CertExaminer *sharedInstance = nil; 

+ (void)setupDefaults
{
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
//    NSDictionary *initialValuesDict;
//    NSArray *resettableUserDefaultsKeys;
	
    // load the default values for the user defaults
    userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults"
														   ofType:@"plist"];
    userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
	
    // set them in the standard user defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
	
    // if your application supports resetting a subset of the defaults to
    // factory values, you should set those values
    // in the shared user defaults controller
//    resettableUserDefaultsKeys=[NSArray arrayWithObjects:@"Value1",@"Value2",@"Value3",nil];
//    initialValuesDict=[userDefaultsValuesDict dictionaryWithValuesForKeys:resettableUserDefaultsKeys];
//	
    // Set the initial values in the shared user defaults controller
//    [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:initialValuesDict];
}

+ (void)initialize
{
    if (sharedInstance == nil)
        sharedInstance = [[self alloc] init];
	[self setupDefaults];
}

+ (id)sharedCertExaminer
{
    //Already set by +initialize.
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone*)zone
{
    //Usually already set by +initialize.
    @synchronized(self) {
        if (sharedInstance) {
            //The caller expects to receive a new object, so implicitly retain it
            //to balance out the eventual release message.
            return sharedInstance;
        } else {
            //When not already set, +initialize is our caller.
            //It's creating the shared instance, let this go through.
            return [super allocWithZone:zone];
        }
    }
}

- (id)init
{
    //If sharedInstance is nil, +initialize is our caller, so initialize the instance.
    //If it is not nil, simply return the instance without re-initializing it.
    if (sharedInstance == nil) {
		self = [super init];
		if (self) {
			userDefaults = [NSUserDefaults standardUserDefaults];
        }
    }
    return self;
}

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

#pragma mark - Table View Datasource
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

#pragma mark IBActions

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
	//	NSNib *nib = [[NSNib alloc] initWithNibNamed:@"Preferences" bundle:nil];
	
    // At this pint, our outlets to inside this nib will be properly setup. It is important to note
    // that they will get overwritten when this is called again!
    // In general, it is good practice to use a unique controller object for each nib you load.
    // You will normally pass that controller as the 'owner'. For simplicity purposes we are passing
    // in this object as the owner.
    //
	prefsWindowController = [[PrefsWindowController alloc] initWithWindowNibName:@"Preferences"];
	prefsWindow = [prefsWindowController window];
	//    [nib instantiateNibWithOwner:prefsWindowController topLevelObjects:nil];
    [prefsWindow makeKeyAndOrderFront:nil];
}

- (IBAction)compare:(NSToolbarItem *)sender {
}
@end
