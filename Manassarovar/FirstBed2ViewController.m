//
//  FirstBed2ViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "FirstBed2ViewController.h"
#import "AppManager.h"
#import "JConstant.h"
#import "NSURLRequest1.h"

@interface FirstBed2ViewController ()

@end

@implementation FirstBed2ViewController

NSString *yuname;
NSString *ypwd;
NSString *rajuUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"appbackground.png"]];
    
    // Do any additional setup after loading the view from its nib.
    
    
    _fstBed2FanLevel.minimumValue=1.0;
    _fstBed2FanLevel.maximumValue=100.0;
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom2Light1]) {
        
        [self.fstBed2Light1 setOn:YES];
    }
    else{
        [self.fstBed2Light1 setOn:NO];
    }
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom2Bulb]) {
        
        [self.fstBed2bulb setOn:YES];
    }
    else{
        [self.fstBed2bulb setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom2Fan1]) {
        
        [self.fstBed2Fan1 setOn:YES];
    }
    else{
        [self.fstBed2Fan1 setOn:NO];
    }
    //
    
    
    if([[AppManager sharedManager]switchValueForKey:fstRoom2RopeLight]) {
        
        [self.fstBed2RopeLights1Btn setOn:YES];
    }
    else{
        [self.fstBed2RopeLights1Btn setOn:NO];
    }if([[AppManager sharedManager]switchValueForKey:fstRoom2Heater]) {
        
        [self.fstBed2HeaterBtn setOn:YES];
    }
    else{
        [self.fstBed2HeaterBtn setOn:NO];
    }
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);
    

    _shutAllFstBed2Btn.layer.cornerRadius = 10;
    _shutAllFstBed2Btn.clipsToBounds = YES;
    _shutAllFstBed2Btn.layer.borderWidth = 2;
    _shutAllFstBed2Btn.layer.borderColor = [UIColor blackColor].CGColor;
    
    
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




- (IBAction)heaterFstBed2Button:(id)sender {
    
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom2Heater];
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Heater\", \"operation\": \"ON\"}",yuname,ypwd];
        
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
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Heater];
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Heater\", \"operation\": \"OFF\"}",yuname,ypwd];
        
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
        
        
        
    }
    
    
    
    
    
}






- (IBAction)ropeLightsFstBed2Button:(id)sender {
    
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom2RopeLight];
        
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2RopeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
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
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2RopeLight];
        
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2RopeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
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
        
        
    }
    
    
    
}






- (IBAction)bulbFstBed2Button:(id)sender {
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom2Bulb];
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Bulb\", \"operation\": \"ON\"}",yuname,ypwd];
        
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
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Bulb];
        
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Bulb\", \"operation\": \"OFF\"}",yuname,ypwd];
        
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
        
        
    }
    
    
    
}

- (IBAction)lightFstBed2Button:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom2Light1];
        
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2TubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
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
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Light1];
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
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
        
        
        
    }
    
    
    
}
- (IBAction)fanFstBed2Button:(id)sender {
    
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstRoom2Fan1];
        
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Fan\", \"operation\": \"ON\"}",yuname,ypwd];
        
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
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Fan1];
        
        
        
        NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Fan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
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
        
        
        
        
        
        
    }
    
    
    
}

- (IBAction)fanLevelFstBed2Button:(UISlider *)sender {
    
    
    if ([sender value]<=10) {
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.207/sw5/OFF"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"OFF";
            
            _fstBed2fan_level.text=String;
            
            
            
        }
        
        
        
        
    }
    else if ([sender value]<=40){
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.207/sw5/L1"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"1";
            
            _fstBed2fan_level.text=String;
            
            
            
        }
        
        
        
        
        
    }
    else if ([sender value]<=70){
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.207/sw5/L2"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"2";
            
            _fstBed2fan_level.text=String;
            
            
            
        }
        
        
        
        
    }
    else{
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.207/sw5/ON"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"High";
            
            _fstBed2fan_level.text=String;
            
            
            
        }
        
        
        
        
    }
    
    
}

- (IBAction)shutAllFstBed2Button:(id)sender {
    
    
    NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllFirstFloorBedRoom2\", \"operation\": \"OFF\"}",yuname,ypwd];
    
//    NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllFirstFloorBedRoom2\", \"operation\": \"OFF\"}",yuname,ypwd]essionWithConfiguration:config];
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
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
    

    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Heater];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2RopeLight];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Bulb];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Light1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstRoom2Fan1];


    [_fstBed2bulb setOn:NO animated:YES];
    [_fstBed2Light1 setOn:NO animated:YES];
    [_fstBed2Fan1 setOn:NO animated:YES];
    [_fstBed2RopeLights1Btn setOn:NO animated:YES];
    [_fstBed2HeaterBtn setOn:NO animated:YES];
//
    
    
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
