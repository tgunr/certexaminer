//
//  PMShell.h
//  CertExaminer
//
//  Created by Dave Carlton on 08/02/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PMShell : NSObject
{
    NSString *command;
    NSArray *arguments;
    NSString *result;
    NSError *cmdError;
}

@property (nonatomic, retain) NSString *command;
@property (nonatomic, retain) NSArray *arguments;
@property (nonatomic, retain) NSString *result;
@property (nonatomic, retain) NSError *cmdError;

- (id)initWithCommand: (NSString*)aCommand;
- (BOOL)doCommand;
@end
