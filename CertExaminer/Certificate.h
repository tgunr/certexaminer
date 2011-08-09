//
//  Certificate.h
//  CertExaminer
//
//  Created by Dave Carlton on 08/01/11.
//  Copyright 2011 Polymicro Systems. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Certificate : NSObject
{
    NSURL *certURL;
    NSString * fileContent;
    NSError *certError;
}

@property (nonatomic, retain) NSURL *certURL;
@property (nonatomic, retain) NSString *fileContent;
@property (nonatomic, retain) NSError *certError;

- (id)initWithCertURL:(NSURL*)aCertURL;
- (void)examineURL;
- (NSString *)type;
@end

@interface PEMCertificate : Certificate {
@private
    NSDictionary *certDictionary;
}
@property (strong) NSDictionary *certDictionary;
@end