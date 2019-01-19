//
//  GroundHallViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "GroundHallViewController.h"
#import "JConstant.h"
#import "AppManager.h"
#import "NSURLRequest1.h"

@interface GroundHallViewController ()



@end

@implementation GroundHallViewController


NSString *yuname;
NSString *ypwd;
NSString *rajuUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage      imageNamed:@"aqua.jpg"]];
    
    // Do any additional setup after loading the view from its nib.
    
    _GrFan1LevelBtn.minimumValue=1.0;
    _GrFan1LevelBtn.maximumValue=100.0;
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);

    
    rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
    
    
    
    if([[AppManager sharedManager]switchValueForKey:grHallfan1]) {
        
        [self.GrHallFan1Btn setOn:YES];
    }
    else{
        [self.GrHallFan1Btn setOn:NO];
    }
    
    
    
    
    if([[AppManager sharedManager]switchValueForKey:grHallLight1]) {
        
        [self.HallLight1Btn setOn:YES];
    }
    else{
        [self.HallLight1Btn setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:grHalldown1Ligh1]) {
        
        [self.grHallDnLights1 setOn:YES];
    }
    else{
        [self.grHallDnLights1 setOn:NO];
    }
    
    
    
    if([[AppManager sharedManager]switchValueForKey:grHalldownLight2]) {
        
        [self.grhallDnLights2 setOn:YES];
    }
    else{
        [self.grhallDnLights2 setOn:NO];
    }
    
    
    //
    
//    if([[AppManager sharedManager]switchValueForKey:grHallRopeLight]) {
//
//        [self.grHallRopelights2Btn setOn:YES];
//    }
//    else{
//        [self.grHallRopelights2Btn setOn:NO];
//    }
    
    
    /* if([[AppManager sharedManager]switchValueForKey:grHallfanLevel]) {
     
     [self.GrFan1LevelBtn setEnabled:YES];
     }
     else{
     [self.GrFan1LevelBtn setEnabled:NO];
     }*/
    
    
    
    _shutAllBtnGrdBtn.layer.cornerRadius = 10;
    _shutAllBtnGrdBtn.clipsToBounds = YES;
    _shutAllBtnGrdBtn.layer.borderWidth = 2;
    _shutAllBtnGrdBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    
    
    
    
}
- (IBAction)curtainUpGrHallButton:(id)sender {
    
    
   
    
     NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallCurtainUp\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
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
        NSLog(@" this is ground ±Hall %@", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
}

- (IBAction)curtainDownHallButton:(id)sender {
    
    
    
     NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallCurtainDown\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
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
        NSLog(@" this is ground ±Hall %@", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
}





- (IBAction)FrFan1LevelHalButton:(UISlider *)sender {
    if ([sender value]<=10) {
        
        // [[AppManager sharedManager]setSwitchValue:YES forKey:grHallfanLevel];
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.203/sw5/OFF"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            NSString*String=@"OFF";
            _fan_level.text=String;
            
        }
        
        
    }
    else if ([sender value]<=40){
        
        //  [[AppManager sharedManager]setSwitchValue:YES forKey:grHallfanLevel];
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.203/sw5/L1"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            NSString*String=@"1";
            _fan_level.text=String;
            
        }
        
        
        
    }
    else if ([sender value]<=70){
        //[[AppManager sharedManager]setSwitchValue:YES forKey:grHallfanLevel];
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.203/sw5/L2"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        
        if (response!=0) {
            NSString*String=@"2";
            _fan_level.text=String;
            
        }
        
        
        
        
    }
    else{
        //  [[AppManager sharedManager]setSwitchValue:NO forKey:grHallfanLevel];
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.203/sw5/ON"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        
        if (response!=0) {
            NSString*String=@"High";
            _fan_level.text=String;
            
        }
        
        
    }
    
    
    
    
    
    
}



- (IBAction)GrFan1HallButton:(id)sender {
    
    
    
    
    
    //GrHallFan1Btn
    if([sender isOn])
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grHallfan1];
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
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
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    else
    {
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grHallfan1];
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
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
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
}


- (IBAction)DownLight2HallButton:(id)sender {
    
    
    if([sender isOn])
    {
        
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grHalldownLight2];
        
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight2\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        // NSURL *url = [NSURL URLWithString:rajuUrl];
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
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
            
            NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            NSLog(@"%@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        NSLog(@"mahesh");
        
    }
    else
    {
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grHalldownLight2];
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight2\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        //NSURL *url = [NSURL URLWithString:rajuUrl];
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
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
            
            NSLog(@"%@", data);
            
            NSDictionary *json =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:0
                                              error:nil];
            NSLog(@"%@", json);
            //access(json);
        }];
        
        [dataTask resume]; // Executed First
        
        NSLog(@"babu");
        
    }
    
    
}
/*
 +(BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
 {
 return YES;
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
 
 
 */

- (IBAction)DownLight1HallButton:(id)sender {
    
    
    if([sender isOn])
    {
        [[AppManager sharedManager]setSwitchValue:YES forKey:grHalldown1Ligh1];
        
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
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
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
    }
    else
    {
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grHalldown1Ligh1];
        
        
        
        
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
       // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        
        
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
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
}



- (IBAction)Light1HallButton:(id)sender {
    
    
    if([sender isOn])
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grHallLight1];
        
        
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallRopeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        //NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@"mahesh");
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
    }
    else
    {
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grHallLight1];
        
        
        
        
         NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallRopeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        //NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@"mahesh");
            NSLog(@" this is ground ±Hall %@", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
    }
    
    
    
}



- (IBAction)shutAllGrrHallButton:(id)sender {
    
    
    
    
     NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllGroundFloorHall\", \"operation\": \"OFF\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
   // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
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
        NSLog(@" this is ground ±Hall %@", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    [[AppManager sharedManager]setSwitchValue:NO forKey:grHallfan1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grHalldownLight2];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grHalldown1Ligh1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grHallLight1];
    

    
    [_GrHallFan1Btn setOn:NO animated:YES];
    [_grhallDnLights2 setOn:NO animated:YES];
    [_grHallDnLights1 setOn:NO animated:YES];
    [_HallLight1Btn setOn:NO animated:YES];
//    [_grHallRopelights2Btn setOn:NO animated:YES];
    
    
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


@end
