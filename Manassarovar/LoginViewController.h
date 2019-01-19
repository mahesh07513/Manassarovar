//
//  LoginViewController.h
//  Final_Yanam001
//
//  Created by Jochebed Tech Mac Mini 1 on 07/11/16.
//  Copyright © 2016 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>



@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;


//@property(nonatomic) BOOL *txtUsername;
- (IBAction)logInClicked:(id)sender;


@end
