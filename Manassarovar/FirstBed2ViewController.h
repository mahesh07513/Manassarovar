//
//  FirstBed2ViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstBed2ViewController : UIViewController


@property (nonatomic, strong) NSString *IPAddress;

- (id)initWithString:(NSString *)ipaddress;




@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;



@property (strong, nonatomic) IBOutlet UISwitch *fstBed2bulb;
@property (strong, nonatomic) IBOutlet UILabel *fstBed2fan_level;


@property (strong, nonatomic) IBOutlet UISwitch *fstBed2Light1;

@property (strong, nonatomic) IBOutlet UISwitch *fstBed2Fan1;

@property (strong, nonatomic) IBOutlet UISlider *fstBed2FanLevel;

@property (retain, nonatomic) IBOutlet UISwitch *fstBed2RopeLights1Btn;

@property (retain, nonatomic) IBOutlet UISwitch *fstBed2HeaterBtn;

@property (retain, nonatomic) IBOutlet UIButton *shutAllFstBed2Btn;


@end
