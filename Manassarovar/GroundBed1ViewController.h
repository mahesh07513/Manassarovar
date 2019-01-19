//
//  GroundBed1ViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundBed1ViewController : UIViewController

@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *bed1fan_level;





@property (strong, nonatomic) IBOutlet UISwitch *grBd1Light1Btn;

@property (strong, nonatomic) IBOutlet UISwitch *grBd1DownLight1Btn;
@property (strong, nonatomic) IBOutlet UISwitch *grBd1FanBtn;
@property (strong, nonatomic) IBOutlet UISlider *grBd1LevelFanBtn;

@property (retain, nonatomic) IBOutlet UISwitch *grBd1RopeLightBtn;
@property (retain, nonatomic) IBOutlet UIButton *shutAllgrBed1Btn;

@end
