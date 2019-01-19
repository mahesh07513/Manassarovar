//
//  FirstBed1ViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstBed1ViewController : UIViewController


@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (strong, nonatomic) IBOutlet UILabel *fstbed1fan_level;



@property (strong, nonatomic) IBOutlet UISwitch *fstBed1HallLight1;

@property (strong, nonatomic) IBOutlet UISwitch *fstBed1HallDownLight1;

@property (strong, nonatomic) IBOutlet UISwitch *fstBed1Bulb;

@property (strong, nonatomic) IBOutlet UISwitch *fstBed1Fan1;
@property (strong, nonatomic) IBOutlet UISlider *fstBed1FanLevel1;
@property (retain, nonatomic) IBOutlet UISwitch *fstBed1HeaterBtn;

@property (retain, nonatomic) IBOutlet UIButton *shutAllFstBed1Btn;

@end
