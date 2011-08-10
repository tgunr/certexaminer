//
//  PMPath.m
//  PathFinder
//
//  Created by Dave Carlton on 07/26/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "PMPath.h"


@implementation PMPath
@synthesize ourPath;
@synthesize isFolder;

//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (PMPath *)initWithPath: (NSString *)aPath isDirectory: (BOOL)truth
{
    self = [super init];
    if (self) {
        ourPath = aPath;
		isFolder = truth;
    }
    return self;
}

- (NSString *)description
{
    NSString *theDesciption = [NSString stringWithFormat:@"ourPath: %@ isFolder: %d", ourPath, isFolder];
    return theDesciption;
}

- (NSString *)path 
{ 
    return ourPath; 
}

- (PMPath *)newPathByAppendingString: (NSString *)component doesExist: (BOOL *)truth;
{
	NSString *fullPath = [ourPath stringByAppendingPathComponent:component];
	NSFileManager *fm = [NSFileManager defaultManager];
	BOOL isafolder;
	*truth = [fm fileExistsAtPath:fullPath isDirectory:&isafolder];
	PMPath *newPath = [[PMPath alloc] initWithPath:fullPath isDirectory:isafolder];
	return newPath;
}

- (NSString *)pathAsString
{
	return ourPath;
}

- (NSURL *)pathAsURL
{
	NSURL *aURL = [NSURL URLWithString:ourPath];
	return aURL;
}

- (NSDictionary *)pathAttributes 
{
    NSFileManager *fm = [NSFileManager defaultManager];
	NSError * error = nil;
	NSDictionary *fileDict = [fm attributesOfItemAtPath:ourPath error:&error];
	return fileDict;
}

@end
