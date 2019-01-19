//
//  LoginViewController.m
//  Final_Yanam001
//
//  Created by Jochebed Tech Mac Mini 1 on 07/11/16.
//  Copyright © 2016 com. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _txtUsername.delegate=self;
    _txtPassword.delegate=self;
    _txtPassword.text =@"";
    _txtPassword.secureTextEntry=YES;
    
    [_txtPassword setClearsOnBeginEditing:YES];
    self.txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;

   
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // _txtUsername.text = @"";
    _txtPassword.text = @"";
    
    // passwordField.text = @"";
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logInClicked:(id)sender{


    
    NSString *Uname = _txtUsername.text;
    NSString *pwd = _txtPassword.text;
    
    //NSString *valueToSave = _txtPassword.text;
    [[NSUserDefaults standardUserDefaults] setObject:Uname forKey:@"nusername"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //NSString *valueToSave1 = _txtUsername.text;
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:@"mpassword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    NSHTTPURLResponse *response ;
    NSInteger success=3;
    @try {
        
        if([[self.txtUsername text] isEqualToString:@""] || [[self.txtPassword text] isEqualToString:@""] ) {
            
            [self alertStatus:@"Please enter Email and Password" :@"Sign in Failed!" :3];
            
        } else {
//            //            NSString *Uname = _txtUsername.text;
//            //            NSString *pwd = _txtPassword.text;
//            //
//            NSString *valueToSave = _txtPassword.text;
//            [[NSUserDefaults standardUserDefaults] setObject:valueToSave forKey:@"samplevaluekey"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//            NSString *valueToSave1 = _txtUsername.text;
//            [[NSUserDefaults standardUserDefaults] setObject:valueToSave1 forKey:@"samplevaluekey1"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSLog(@" this Usr %@",Uname);
            NSLog(@" this pass %@",pwd);
            
            
           // NSString *rajuUrl=@"https://jts-raju.in/service/get_device";
            
            
            NSString *post=[[NSString alloc]initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\"}",Uname,pwd];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"https://jts-raju.in/service/validate_web"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
            
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            
            
            NSError *error = [[NSError alloc] init];
            response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization                                          JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:&error];
                
                success = [jsonData[@"error_code"] integerValue];
                
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 0)
                {
                    NSLog(@"Login SUCCESS");
                    
                   
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :3];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Internet Connection Failed. Please check  " :@"Sign in Failed!" :3];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :3];
    }
    
    
    
    
    if (success==0) {

        [self performSegueWithIdentifier:@"login_success" sender:self];
        NSLog(@"in success segue");

    }

    
}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title  message:msg  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
   // _txtPassword.text =@"";
    
    [textField resignFirstResponder];
    return YES;
}








@end
