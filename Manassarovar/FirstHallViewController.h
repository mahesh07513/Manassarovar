//
//  FirstHallViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstHallViewController : UIViewController

@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *fstHallFan_level;



@property (strong, nonatomic) IBOutlet UISwitch *fstHallLight1Btn;

@property (strong, nonatomic) IBOutlet UISwitch *fstHallDownLight1Btn;

//@property (strong, nonatomic) IBOutlet UISwitch *fstHallDownLight2Btn;


@property (strong, nonatomic) IBOutlet UISwitch *fstHallFan1Btn;

@property (strong, nonatomic) IBOutlet UISlider *fstHallFanLevelBtn;

@property (retain, nonatomic) IBOutlet UISwitch *fstHallRopeLightsBtn;

@property (retain, nonatomic) IBOutlet UISwitch *fstHallRopeLights2Btn;
@property (retain, nonatomic) IBOutlet UIButton *fstHallCurtainUP;
@property (retain, nonatomic) IBOutlet UIButton *fstHallCurtainDown;



@property (retain, nonatomic) IBOutlet UIButton *fstshutallBtn;



@end
