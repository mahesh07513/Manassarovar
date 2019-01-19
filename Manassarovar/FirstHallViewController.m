//
//  FirstHallViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "FirstHallViewController.h"
#import "AppManager.h"
#import "JConstant.h"
#import "NSURLRequest1.h"

@interface FirstHallViewController ()

@end

@implementation FirstHallViewController

NSString *yuname;
NSString *ypwd;

NSString *rajuUrl;

@synthesize fstHallFanLevelBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"appbackground.png"]];
    
    fstHallFanLevelBtn.minimumValue=1.0;
    fstHallFanLevelBtn.maximumValue=100.0;
    
    
    if([[AppManager sharedManager]switchValueForKey:fstHallLight1]) {
        
        [self.fstHallLight1Btn setOn:YES];
    }
    else{
        [self.fstHallLight1Btn setOn:NO];
    }
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstHalldown1Ligh1]) {
        
        [self.fstHallDownLight1Btn setOn:YES];
    }
    else{
        [self.fstHallDownLight1Btn setOn:NO];
    }
    
    
    
    
    
//    if([[AppManager sharedManager]switchValueForKey:fstHalldownLight2]) {
//
//        [self.fstHallDownLight2Btn setOn:YES];
//    }
//    else{
//        [self.fstHallDownLight2Btn setOn:NO];
//    }
    
    
    
    
    if([[AppManager sharedManager]switchValueForKey:fstHallfan1]) {
        
        [self.fstHallFan1Btn setOn:YES];
    }
    else{
        [self.fstHallFan1Btn setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:fstHallRopeLight1]) {
        
        [self.fstHallRopeLightsBtn setOn:YES];
    }
    else{
        [self.fstHallRopeLightsBtn setOn:NO];
    }
    
    
    if([[AppManager sharedManager]switchValueForKey:fstHallRopeLight2]) {
        
        [self.fstHallRopeLights2Btn setOn:YES];
    }
    else{
        [self.fstHallRopeLights2Btn setOn:NO];
    }
    
    
    
    /* if([[AppManager sharedManager]switchValueForKey:fstHallfanLevel]) {
     
     [self.fstHallFan_level setOn:YES];
     }
     else{
     [self.fstHallFan_level setOn:NO];
     }*/
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);
    
    
    _fstshutallBtn.layer.cornerRadius = 10;
    _fstshutallBtn.clipsToBounds = YES;
    _fstshutallBtn.layer.borderWidth = 2;
    _fstshutallBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    
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




- (IBAction)shutAllFstButton:(id)sender {
    
    
    
    
    NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllFirstFloorHall\", \"operation\": \"OFF\"}",yuname,ypwd];
    
    NSString *jsonRequest = jsonInputString;
    
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
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallRopeLight1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallRopeLight2];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallLight1];
    
    
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstHalldown1Ligh1];
    [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallfan1];
    
    
    
    [_fstHallLight1Btn setOn:NO animated:YES];
    [_fstHallDownLight1Btn setOn:NO animated:YES];
//    [_fstHallDownLight2Btn setOn:NO animated:YES];
    [_fstHallFan1Btn setOn:NO animated:YES];
    [_fstHallRopeLightsBtn setOn:NO animated:YES];
    [_fstHallRopeLights2Btn setOn:NO animated:YES];
    
                                
    
    
    
    
}





- (IBAction)ropeLights1FstHallButton:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstHallRopeLight1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallRopeLight1\", \"operation\": \"ON\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
    
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallRopeLight1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallRopeLight1\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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

- (IBAction)ropeLights2fstHallButton:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstHallRopeLight2];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallRopeLight2\", \"operation\": \"ON\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallRopeLight2];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallRopeLight2\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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

- (IBAction)fstHallCurtainUp:(id)sender {
    
    
    
    
    NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallCurtainUp\", \"operation\": \"ON\"}",yuname,ypwd];
    
    NSString *jsonRequest = jsonInputString;
    
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

- (IBAction)fstHallCurtainDown:(id)sender {
    
    
    NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallCurtainDown\", \"operation\": \"ON\"}",yuname,ypwd];
    
    NSString *jsonRequest = jsonInputString;
    
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

- (IBAction)fanLevelFstButton:(UISlider *)sender {
    
    
    
    if ([sender value]<=10) {
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.204/sw5/OFF"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"OFF";
            
            _fstHallFan_level.text=String;
            
            
            
        }
        
        
    }
    else if ([sender value]<=40){
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.204/sw5/L1"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"1";
            
            _fstHallFan_level.text=String;
            
            
            
        }
        
        
    }
    else if ([sender value]<=70){
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.204/sw5/L2"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        
        if (response!=0) {
            
            NSString*String=@"2";
            
            _fstHallFan_level.text=String;
            
            
            
        }
        
        
        
    }
    else{
        
        
        
        [self.connection cancel];
        
        //initialize new mutable data
        NSMutableData *data = [[NSMutableData alloc] init];
        self.receivedData = data;
        
        //initialize url that is going to be fetched.
        NSURL *url = [NSURL URLWithString:@"http://192.168.1.204/sw5/ON"];
        
        //initialize a request from url
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
        
        NSURLResponse *response = [[NSURLResponse alloc] init];
        
        [self.receivedData appendData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil]];
        if (response!=0) {
            
            NSString*String=@"High";
            
            _fstHallFan_level.text=String;
            
            
            
        }
        
    }
    
    
}

- (IBAction)light1FstHallButon:(id)sender {
    
    //BOOL isOn = [ [ NSUserDefaults standardUserDefaults ] boolForKey:@"lights" ] ;
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstHallLight1];
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallTubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallLight1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallTubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
- (IBAction)downLight1FstHallButton:(id)sender {
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstHalldown1Ligh1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallDownLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
        
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstHalldown1Ligh1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallDownLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
        NSError *error = nil;
        NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
        
        //  [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
       
        
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
/*
 - (IBAction)downLight2FstHallButton:(id)sender {
 
 if([sender isOn])
 
 {
 
 [[AppManager sharedManager]setSwitchValue:YES forKey:fstHalldownLight2];
 
 
 
 NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"Iot_fan\", \"operation\": \"ON\"}",yuname,ypwd];
 
 NSString *jsonRequest = jsonInputString;
 
 NSURL *url = [NSURL URLWithString:rajuUrl];
 
 NSURLSessionConfiguration *config =
 [NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
 
 // 2: Create NSMutableRequest object
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
 request.HTTPMethod = @"POST";
 
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
 
 
 [[AppManager sharedManager]setSwitchValue:NO forKey:fstHalldownLight2];
 
 
 
 NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"Iot_fan\", \"operation\": \"OFF\"}",yuname,ypwd];
 
 NSString *jsonRequest = jsonInputString;
 
 NSURL *url = [NSURL URLWithString:rajuUrl];
 
 NSURLSessionConfiguration *config =
 [NSURLSessionConfiguration defaultSessionConfiguration];
 NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
 
 // 2: Create NSMutableRequest object
 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
 request.HTTPMethod = @"POST";
 
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
 */
- (IBAction)fan1FstHallButton:(id)sender {
    
    if([sender isOn])
        
    {
        [[AppManager sharedManager]setSwitchValue:YES forKey:fstHallfan1];
        
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallFan\", \"operation\": \"ON\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:fstHallfan1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallFan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        NSString *jsonRequest = jsonInputString;
        
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
