//
//  Certificate.m
//  CertExaminer
//
//  Created by Dave Carlton on 08/01/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Security/Security.h>
#import "Certificate.h"
#import "PMShell.h"

@implementation Certificate

@synthesize certURL;
@synthesize fileContent;
@synthesize certError;

- (id)initWithCertURL:(NSURL*)aCertURL  
{
    self = [super init];
    if (self) {
        certURL = aCertURL;
        [self examineURL];
    }
    return self;
}

- (void)examineURL
{
    NSError *result;
    
    NSFileManager *fm = [NSFileManager defaultManager];
//    NSDictionary *fileDictionary = [fm attributesOfItemAtPath:[certURL path] error:&result];
    if (![fm isReadableFileAtPath: [certURL path]] ) {
        OSStatus status;
        AuthorizationRef authorizationRef;
        AuthorizationItem right = { "com.polymicrosystems.certexaminer.opencert", 0, NULL, 0 };
        AuthorizationRights rightSet = { 1, &right };AuthorizationFlags flags = 
                                                        kAuthorizationFlagExtendRights |
                                                        kAuthorizationFlagInteractionAllowed;
        
        /* Create a new AuthorizationRef object, but pass in NULL for the
         AuthorizationRights set so the AuthorizationRef can be used in future calls. */
        
        status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment,
                                     kAuthorizationFlagDefaults, &authorizationRef);
        if (status == errAuthorizationSuccess)
        {
            /* Now we can use the AuthorizationRef to deterimine if the user is
             allowed to perform the rights contained in "rightSet". */
            
            status = AuthorizationCopyRights(authorizationRef, &rightSet,
                                             kAuthorizationEmptyEnvironment, flags, NULL);
        }

    }
    BOOL ok = [fm isReadableFileAtPath: [certURL path]];
    if (ok) {
        PMShell *shell =[[PMShell alloc] initWithCommand: @"file"];
        [shell setArguments:[NSArray arrayWithObject:[certURL path]]];
        ok = [shell doCommand];
        NSString *cmdResult = [shell result];
        NSLog(@"shell: %@", cmdResult);
        if (ok) {
            fileContent = [NSString stringWithContentsOfURL:certURL encoding:NSUTF8StringEncoding error:&result];
            
        }
    }
}

- (NSString *)type {
    if ([fileContent hasPrefix:@"----"] ) {
    }
    return @"PEM";
}
@end

@implementation PEMCertificate
@synthesize certDictionary;


@end