//
//  AppManager.m
//  sample
//
//  Created by Wooqer on 27/09/16.
//  Copyright © 2016 Wooqer. All rights reserved.
//

#import "AppManager.h"

// ground BedRoom 1

NSString* const grRoom1Light1 = @"grRoom1Light1";
NSString* const grRoom1down1Ligh1 = @"grRoom1down1Ligh1";
NSString* const grRoom1Fan1 = @"grRoom1Fan1";
NSString* const grRoom1RopeLight = @"grRoom1RopeLight";
NSString* const grRoom1FanLevel = @"grRoom1FanLevel";


// Ground BedRoom 2


NSString* const grRoom2Light1 = @"grRoom2Light1";
NSString* const grRoom2downLight1 = @"grRoom2downLight1";
NSString* const grRoom2Fan1 = @"grRoom2Fan1" ;
NSString* const grRoom2RopeLight = @"grRoom2RopeLight" ;
NSString* const grRoom2FanLevel = @"grRoom2FanLevel" ;

// Ground Hall


NSString* const grHallLight1 = @"grHallLight1";
NSString* const grHalldown1Ligh1 = @"grHalldown1Ligh1";
NSString* const grHalldownLight2 = @"grHalldownLight2";
NSString* const grHallfan1 = @"grHallfan1";
NSString* const grHallRopeLight = @"grHallRopeLight";
NSString* const grHallfanLevel = @"grHallfanLevel";

// ground Parking


NSString* const grParkingLight1 = @"grParkingLight1";
NSString* const grParkingLight2 = @"grParkingLight2";


//First BedRoom 1

NSString* const fstRoom1Light1 = @"fstRoom1Light1";
NSString* const fstRoom1down1Ligh1 = @"fstRoom1down1Ligh1";
NSString* const fstRoom1Bulb = @"fstRoom1Bulb";
NSString* const fstRoom1Fan1 = @"fstRoom1Fan1";
NSString* const fstRoom1Heater = @"fstRoom1Heater";
NSString* const fstRoom1FanLevel = @"fstRoom1FanLevel";


// First BedRoom 2

NSString* const fstRoom2Light1 = @"fstRoom2Light1";
NSString* const fstRoom2Bulb = @"fstRoom2Bulb";
NSString* const fstRoom2Fan1 = @"fstRoom2Fan1";
NSString* const fstRoom2RopeLight = @"fstRoom2RopeLight";
NSString* const fstRoom2Heater = @"fstRoom2Heater";
NSString* const fstRoom2FanLevel = @"fstRoom2FanLevel";


// First Hall

NSString* const fstHallLight1 = @"fstHallLight1";
NSString* const fstHalldown1Ligh1 = @"fstHalldown1Ligh1";
NSString* const fstHalldownLight2 = @"fstHalldownLight2";
NSString* const fstHallfan1 = @"fstHallfan1";
NSString* const fstHallRopeLight1 = @"fstHallRopeLight1";
NSString* const fstHallRopeLight2 = @"fstHallRopeLight2";
NSString* const fstHallfanLevel = @"fstHallfanLevel";

// First Dining

NSString* const fstDiningDownLight1 = @"fstDiningDownLight1";
NSString* const fstDiningBulb = @"fstDiningBulb";
NSString* const fstDiningOutSideLight=@"fstDiningOutSideLight";










@implementation AppManager

+ (instancetype)sharedManager {
    static dispatch_once_t pred;
    static AppManager *sharedManager = nil;
    dispatch_once(&pred, ^{
        sharedManager = [[AppManager alloc] init];
    });
    return sharedManager;
}

- (void)setSwitchValue:(BOOL)value forKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

- (BOOL)switchValueForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

@end
