//
//  PMPath.h
//  PathFinder
//
//  Created by Dave Carlton on 07/26/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PMPath : NSObject {
	@private
	NSString *ourPath;
	BOOL isFolder;
}

@property (nonatomic, copy) NSString *ourPath;
@property (nonatomic, assign) BOOL isFolder;

- (PMPath *)initWithPath: (NSString *)aPath isDirectory: (BOOL)truth;
- (NSString *)path;
- (PMPath *)newPathByAppendingString: (NSString *)component doesExist: (BOOL *)truth;
- (NSString *)pathAsString;
- (NSURL *)pathAsURL;
- (NSDictionary *)pathAttributes;

@end
