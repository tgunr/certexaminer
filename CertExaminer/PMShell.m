//
//  PMShell.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/02/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import "PMShell.h"

@implementation PMShell

@synthesize command;
@synthesize arguments;
@synthesize result;
@synthesize cmdError;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.command = nil;
        self.arguments = nil;
        self.result = nil;
        self.cmdError = nil;
    }
    return self;
}


//=========================================================== 
// - (id)initWith:
//
//=========================================================== 
- (id)initWithCommand: (NSString*)aCommand  
{
    self = [super init];
    if (self) {
        command = aCommand;
    }
    return self;
}

- (BOOL)doCommand
{
	char*			utf8String = NULL;
	FILE*			cmdPipe;
	size_t			pipeSize = 8192;
    int             outResult;
    
    NSString *fullCommand = command;
    for (NSString *arg in arguments) {
        fullCommand = [fullCommand stringByAppendingFormat:@" %@", arg];
    }
    const char * cmdStr = [fullCommand UTF8String];
    if ([command length]) {
        cmdPipe = popen(cmdStr, "r");
        
        if (cmdPipe) {
            result = [NSString string];
            utf8String = (char*)calloc(1, pipeSize);
            while (pipeSize) {
                pipeSize = fread(utf8String, (size_t)1, pipeSize, cmdPipe);
                if( pipeSize > 2 ) {
                    result = [result stringByAppendingFormat:@"%s", utf8String];
                } else {
                    break;
                }
            }
            outResult = pclose( cmdPipe );
            if (outResult) {
                goto doError;
            }
            return YES;
        }
    } 

doError:
    {
        NSString *description = nil;
        int errCode;
        
        if (errno == ENOENT) {
            description = NSLocalizedString(@"No command or command malformed", @"");
            errCode = NSFormattingError;
        } else if (errno == EIO) {
            // Continue for each possible POSIX error...
        }
        
        // Make underlying error.
        NSError *underlyingError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                                              code:errno userInfo:nil];
        // Make and return custom domain error.
        NSArray *objArray = [NSArray arrayWithObjects:
                             description, 
                             underlyingError, 
                             fullCommand, 
                             nil];
        NSArray *keyArray = [NSArray arrayWithObjects:
                             NSLocalizedDescriptionKey,
                             NSUnderlyingErrorKey, 
                             NSLocalizedFailureReasonErrorKey, 
                             nil];
        NSDictionary *eDict = [NSDictionary dictionaryWithObjects:objArray
                                                          forKeys:keyArray];
        
        cmdError = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain
                                              code:errCode userInfo:eDict];
        return NO;
    }
}

@end
