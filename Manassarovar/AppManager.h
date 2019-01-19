//
//  AppManager.h
//  sample
//
//  Created by Wooqer on 27/09/16.
//  Copyright © 2016 Wooqer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject
+ (instancetype)sharedManager;

- (void)setSwitchValue:(BOOL)value forKey:(NSString*)key;
- (BOOL)switchValueForKey:(NSString*)key;


@end
