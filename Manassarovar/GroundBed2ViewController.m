//
//  GroundBed2ViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "GroundBed2ViewController.h"
#import "AppManager.h"
#import "JConstant.h"
#import "NSURLRequest1.h"
@interface GroundBed2ViewController ()

@end

@implementation GroundBed2ViewController

NSString *yuname;
NSString *ypwd;
NSString *rajuUrl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"appbackground.png"]];
    
    
    _grBed2LevelFanBtn.minimumValue=1.0;
    _grBed2LevelFanBtn.maximumValue=100.0;
    
    
    
    if([[AppManager sharedManager]switchValueForKey:grRoom2Light1]) {
        
        [self.grBed2Light1Btn setOn:YES];
    }
    else{
        [self.grBed2Light1Btn setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:grRoom2downLight1]) {
        
        [self.grBed2DownLight1Btn setOn:YES];
    }
    else{
        [self.grBed2DownLight1Btn setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:grRoom2Fan1]) {
        
        [self.grBed2Fan1Btn setOn:YES];
    }
    else{
        [self.grBed2Fan1Btn setOn:NO];
    }
    
    //
    if([[AppManager sharedManager]switchValueForKey:grRoom2RopeLight]) {
        
        [self.grBed2RopeLightsBtn setOn:YES];
    }
    else{
        [self.grBed2RopeLightsBtn setOn:NO];
    }
    
    /*if([[AppManager sharedManager]switchValueForKey:grRoom2FanLevel]) {
     
     [self.grBed2LevelFanBtn setEnabled:YES];
     }
     else{
     [self.grBed2LevelFanBtn setEnabled:NO];
     }
     */
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);
    
    _shutAllBtnFstBed2Btn.layer.cornerRadius = 10;
    _shutAllBtnFstBed2Btn.clipsToBounds = YES;
    _shutAllBtnFstBed2Btn.layer.borderWidth = 2;
    _shutAllBtnFstBed2Btn.layer.borderColor = [UIColor blackColor].CGColor;

    
    
    
    
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



- (IBAction)grBed2ShutAllButton:(id)sender {
    
    
    
   
     NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllGroundFloorBedRoom2\", \"operation\": \"OFF\"}",yuname,ypwd];
    
   // NSString *jsonRequest = jsonInputString;
    
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
        NSLog(@"%@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2downLight1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2Fan1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2RopeLight];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2Light1];
    

    
    [_grBed2Light1Btn setOn:NO animated:YES];
    [_grBed2DownLight1Btn setOn:NO animated:YES];
    [_grBed2Fan1Btn setOn:NO animated:YES];
    [_grBed2RopeLightsBtn setOn:NO animated:YES];
    
    
    
}


- (IBAction)grBed2RopeLightsButton:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grRoom2RopeLight];
        
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2RopeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2RopeLight];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2RopeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
}



- (IBAction)grBed2FanLevelButton:(UISlider *)sender {
    
    
    
    if ([sender value]<=10) {
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.201/sw5/OFF"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"OFF";
            
            _bed2fan_level.text=String;
            
            
            
        }
        
        
    }
    else if ([sender value]<=40){
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.201/sw5/L1"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"1";
            
            _bed2fan_level.text=String;
            
            
            
        }
        
//        NSString *String=@"1";
//
//        _bed2fan_level.text=String;
//
//
//
//        }
        
        
    }

    
    else if ([sender value]<=70){
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.201/sw5/L2"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"2";
            
            _bed2fan_level.text=String;
            
            
            
        }
        
        
        
    }
    else{
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.201/sw5/ON"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"High";
            
            _bed2fan_level.text=String;
            
            
            
        }
        
    }
    
    
    
    
    
}




- (IBAction)grBed2Light1Button:(id)sender {
    
    if([sender isOn])
        
    {
        [[AppManager sharedManager]setSwitchValue:YES forKey:grRoom2Light1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2TubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        //NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2Light1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
}

- (IBAction)grBed2DownLight1Button:(id)sender {
    
    if([sender isOn])
        
    {
        
        
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grRoom2downLight1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2DownLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2downLight1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2DownLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
}


- (IBAction)grBed2FanButton:(id)sender {
    
    if([sender isOn])
        
    {
        [[AppManager sharedManager]setSwitchValue:YES forKey:grRoom2Fan1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2Fan\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grRoom2Fan1];
        
        
        
         NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm2Fan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
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
            NSLog(@"%@ ", json);


            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
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
                                                                                                                                                                                                                                                                
