//
//  GroundHallViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundHallViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *fan_level;


@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UISlider *GrFan1LevelBtn;




@property (strong, nonatomic) IBOutlet UISwitch *GrHallFan1Btn;


@property (strong, nonatomic) IBOutlet UISwitch *grhallDnLights2;


@property (strong, nonatomic) IBOutlet UISwitch *grHallDnLights1;


@property (strong, nonatomic) IBOutlet UISwitch *HallLight1Btn;

//@property (retain, nonatomic) IBOutlet UISwitch *grHallRopelights2Btn;

@property (retain, nonatomic) IBOutlet UIButton *grHallCurtainUp;
@property (retain, nonatomic) IBOutlet UIButton *grHallCurtainDown;


@property (retain, nonatomic) IBOutlet UIButton *shutAllBtnGrdBtn;



@end
