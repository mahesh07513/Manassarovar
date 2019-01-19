//
//  FirstDiningViewController.h
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstDiningViewController : UIViewController


@property (retain, nonatomic) NSMutableData *receivedData;

@property (retain, nonatomic) NSURLConnection *connection;

@property (retain, nonatomic) IBOutlet UISwitch *fstDiningOutsideLight;


@property (strong, nonatomic) IBOutlet UISwitch *fstDiningDownLight;

@property (strong, nonatomic) IBOutlet UISwitch *fstDiningBuld;



@property (retain, nonatomic) IBOutlet UIButton *shutAllfstDiningBtn;



@end
