//
//  GroundParkingViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundParkingViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISwitch *GrParkLight1Btn;

@property (strong, nonatomic) IBOutlet UISwitch *GrParkLight2Btn;

@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (retain, nonatomic) IBOutlet UIButton *shutAllParkingBtn;


@end
