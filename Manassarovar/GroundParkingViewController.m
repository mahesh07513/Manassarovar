//
//  GroundParkingViewController.m
//  Final_Yanam001
//
//  Created by Mac on 22/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "GroundParkingViewController.h"
#import "JConstant.h"
#import "AppManager.h"
#import "NSURLRequest1.h"

@interface GroundParkingViewController ()

@end

@implementation GroundParkingViewController

NSString *yuname;
NSString *ypwd;
NSString *rajuUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
    
//    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"appbackground.png"]];
    
    // Do any additional setup after loading the view from its nib.
    
    
    if([[AppManager sharedManager]switchValueForKey:grParkingLight1]) {
        
        [self.GrParkLight1Btn setOn:YES];
    }
    else{
        [self.GrParkLight1Btn setOn:NO];
    }
    
    if([[AppManager sharedManager]switchValueForKey:grParkingLight2]) {
        
        [self.GrParkLight2Btn setOn:YES];
    }
    else{
        [self.GrParkLight2Btn setOn:NO];
    }
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    yuname = [prefs stringForKey:@"nusername"];
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"user name is : %@, password is :%@",yuname,ypwd);
    

    _shutAllParkingBtn.layer.cornerRadius = 10;
    _shutAllParkingBtn.clipsToBounds = YES;
    _shutAllParkingBtn.layer.borderWidth = 2;
    _shutAllParkingBtn.layer.borderColor = [UIColor blackColor].CGColor;
    
    
    
    
}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:rajuUrl
];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}



- (IBAction)parkingShutAllButton:(id)sender {
    
    
    [[AppManager sharedManager]setSwitchValue:NO forKey:grParkingLight2];
    [[AppManager sharedManager]setSwitchValue:NO forKey:grParkingLight1];
    
    
    NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAllParking\", \"operation\": \"OFF\"}",yuname,ypwd];
    
  
   // NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl
];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    
    // 2: Create NSMutableRequest object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
 //   NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
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
        NSLog(@" this is parking %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    [_GrParkLight1Btn setOn:NO animated:YES];
    [_GrParkLight2Btn setOn:NO animated:YES];
    
}




- (IBAction)grLight2ParkingButton:(id)sender {
    
    
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grParkingLight2];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight2\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl
];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
     //   NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@" this is parking %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grParkingLight2];
        
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight2\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl
];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
     //   NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@" this is parking %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
    
}



- (IBAction)grLight1ParkingButton:(id)sender {
    
   
    if([sender isOn])
        
    {
        
        [[AppManager sharedManager]setSwitchValue:YES forKey:grParkingLight1];
        
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight1\", \"operation\": \"ON\"}",yuname,ypwd];
        
           NSLog(@"mmmmmmm %@",jsonInputString);
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl
];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
     //   NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@" this is parking %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    
    else{
        
        [[AppManager sharedManager]setSwitchValue:NO forKey:grParkingLight1];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight1\", \"operation\": \"OFF\"}",yuname,ypwd];
        
       // NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl
];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        // [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        
        // 2: Create NSMutableRequest object
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
     //   NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        
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
            NSLog(@" this is parking %@ ", json);
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
