//
//  FirstBed1ViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "FirstBed1ViewController.h"
#import "AppManager.h"
#import "JConstant.h"
#import "NSURLRequest1.h"
@interface FirstBed1ViewController ()

@end

@implementation FirstBed1ViewController

NSString *rajuUrl;
NSString *yuname;
NSString *ypwd;


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"appbackground.png"]];
    
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
    _fstBed1FanLevel1.minimumValue=1.0;
    _fstBed1FanLevel1.maximumValue=100.0;
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom1Light1]) {
        
        [self.fstBed1HallLight1 setOn:YES];
    }
    else{
        [self.fstBed1HallLight1 setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom1down1Ligh1]) {
        
        [self.fstBed1HallDownLight1 setOn:YES];
    }
    else{
        [self.fstBed1HallDownLight1 setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom1Bulb]) {
        
        [self.fstBed1Bulb setOn:YES];
    }
    else{
        [self.fstBed1Bulb setOn:NO];
    }
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom1Fan1]) {
        
        [self.fstBed1Fan1 setOn:YES];
    }
    else{
        [self.fstBed1Fan1 setOn:NO];
    }
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom1Heater]) {
        
        [self.fstBed1HeaterBtn setOn:YES];
    }
    else{
        [self.fstBed1HeaterBtn setOn:NO];
    }
    
    
    
    /*if([[AppManager sharedManager]switchValueForKey:fstRoom1FanLevel]) {
     
     [self.fstbed1fan_level setEnabled:YES];
     }
     else{
     [self.fstbed1fan_level setEnabled:NO];
     }
     */
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);

    
    _shutAllFstBed1Btn.layer.cornerRadius = 10;
    _shutAllFstBed1Btn.clipsToBounds = YES;
    _shutAllFstBed1Btn.layer.borderWidth = 2;
    _shutAllFstBed1Btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    // Do any additional setup after loading the view from its nib.
}


-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:rajuUrl];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}




- (IBAction)heaterFstBed1Button:(id)sender {
    
    
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom1Heater];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Heater\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Heater];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Heater\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
    }
    
    
    
    
    
}





- (IBAction)light1FstBed1Button:(id)sender {
    
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom1Light1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1TubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Light1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
    
    
}

- (IBAction)downLight1FstBed1Button:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom1down1Ligh1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1DownLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1down1Ligh1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1DownLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
    
}
- (IBAction)RopeLights:(id)sender {
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:_fstBed1Bulb];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1RopeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:_fstBed1Bulb];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1RopeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
}



- (IBAction)fan1FstBed1Button:(id)sender {
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom1Fan1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Fan1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
        // 3: Create Jsondata object
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        // Asynchronously Api is hit here
        NSURLSessionUploadTask *dataTask =
        [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
            
            //NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            //NSLog(@"%@ %d", json,data);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    
    
    
}

- (IBAction)fanLevelFstBed1Button:(UISlider *)sender {
    
    
    if ([sender value]<=10) {
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.205/sw5/OFF"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"Off";
            
            _fstbed1fan_level.text=String;
            
            
            
        }
        
        
        
        
    }
    else if ([sender value]<=40){
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.205/sw5/L1"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"1";
            
            _fstbed1fan_level.text=String;
            
            
            
        }
        
        
        
        
    }
    else if ([sender value]<=70){
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.205/sw5/L2"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"2";
            
            _fstbed1fan_level.text=String;
            
            
            
        }
        
        
        
    }
    else{
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.205/sw5/ON"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"High";
            
            _fstbed1fan_level.text=String;
            
            
            
        }
        
        
        
    }
    
}

- (IBAction)shutAllFstBed1Button:(id)sender {
    
    
    NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllFirstFloorBedRoom1\", \"operation\": \"OFF\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
    // 2: Create NSMutableRequest object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    // NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    // 3: Create Jsondata object
    //NSError *error = nil;
    NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Asynchronously Api is hit here
    NSURLSessionUploadTask *dataTask =
    [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,                                    NSError *error) {
        
        //NSLog(@"%@", data);
        
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:0
                                          error:nil];
        NSLog(@" bed 2222 %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    

    
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Heater];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Light1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1down1Ligh1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Bulb];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom1Fan1];
        
    
    [_fstBed1HallLight1 setOn:NO animated:YES];
    [_fstBed1HallDownLight1 setOn:NO animated:YES];
    [_fstBed1Bulb setOn:NO animated:YES];
    [_fstBed1Fan1 setOn:NO animated:YES];
    [_fstBed1HeaterBtn setOn:NO animated:YES];
    
   
    
    
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

- (void)dealloc {
    
    
}
@end
