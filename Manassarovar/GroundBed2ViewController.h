//
//  GroundBed2ViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundBed2ViewController : UIViewController


@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *bed2fan_level;


@property (strong, nonatomic) IBOutlet UISwitch *grBed2Light1Btn;
@property (strong, nonatomic) IBOutlet UISwitch *grBed2DownLight1Btn;
@property (strong, nonatomic) IBOutlet UISwitch *grBed2Fan1Btn;

@property (strong, nonatomic) IBOutlet UISlider *grBed2LevelFanBtn;

@property (retain, nonatomic) IBOutlet UISwitch *grBed2RopeLightsBtn;

@property (retain, nonatomic) IBOutlet UIButton *shutAllBtnFstBed2Btn;
@end
