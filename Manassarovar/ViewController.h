//
//  ViewController.h
//  Final_Yanam001
//
//  Created by Mac on 20/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController<UIAlertViewDelegate>
{
    UIAlertView *alertViewObj;
     UIAlertView *alertViewObj2;
    
    //AVAudioPlayer *audioPlayer;
    
    
}

@property (strong, nonatomic) IBOutlet UIButton *alarmButton;
- (IBAction)alarmButAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIProgressView *water_var;
@property (nonatomic, strong) NSTimer *myTimer;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;




//Ground Floor

@property (strong, nonatomic) IBOutlet UIButton *fvFan2Btn;

@property (strong, nonatomic) IBOutlet UIButton *fvDoor1Btn;

@property (strong, nonatomic) IBOutlet UIButton *fvLight4Btn;

@property (strong, nonatomic) IBOutlet UIButton *fvLight2Btn;

@property (retain, nonatomic) IBOutlet UIButton *grfvCurtainUpBtn;

@property (retain, nonatomic) IBOutlet UIButton *grfvCurtainDownBtn;





//First Floor

@property (retain, nonatomic) IBOutlet UIButton *fstfvCurtainUpBtn;

@property (retain, nonatomic) IBOutlet UIButton *fstfvCurtainDownBtn;


@property (retain, nonatomic) IBOutlet UIButton *fvB1LightBtn;

@property (strong, nonatomic) IBOutlet UIButton *fvFan1Btn;

@property (retain, nonatomic) IBOutlet UIButton *fvFan3Btn;


@property (strong, nonatomic) IBOutlet UIButton *fvLight1Btn;



//urls Connection Objects

@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain, nonatomic) NSURLConnection *connection;

//Doors
@property (retain, nonatomic) IBOutlet UIButton *grd1Btn;

@property (retain, nonatomic) IBOutlet UIButton *grd2Btn;



//group Switches

@property (retain, nonatomic) IBOutlet UIButton *groupShutAllBtn;
@property (retain, nonatomic) IBOutlet UIButton *groupLeavingBtn;

@property (retain, nonatomic) IBOutlet UIButton *groupSleepingBtn;
@property (retain, nonatomic) IBOutlet UIButton *groupTvBtn;

@end

