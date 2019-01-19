//
//  NSURLRequest.h
//  Final_Yanam001
//
//  Created by Mac on 14/10/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest1 : NSURLCredential
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;

@end
