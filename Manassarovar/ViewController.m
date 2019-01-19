//
//  ViewController.m
//  Final_Yanam001
//
//  Created by Mac on 20/09/16.
//  Copyright (c) 2016 com. All rights reserved.
//

#import "ViewController.h"
#import "NSURLRequest1.h"

@interface ViewController ()
@property (nonatomic , assign)BOOL isOnOff;
@end

@implementation ViewController

@synthesize receivedData;
@synthesize connection;
NSString *yuname;
NSString *ypwd;
NSString *rajuUrl;
@synthesize audioPlayer;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOnOff = YES;
     rajuUrl=[[NSString alloc ] initWithFormat:@"https://jts-raju.in/service/device"];
    
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage       imageNamed:@"iosbg.png"]];
    //iosbg.png
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
      // getting an NSString
        yuname = [prefs stringForKey:@"nusername"];
    //
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    //    // getting an NSString
        ypwd = [prefs1 stringForKey:@"mpassword"];
    NSLog(@"111111111 %@,  22222222 %@",yuname,ypwd);
    
      _myTimer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(water_level) userInfo:nil repeats:YES];
    
}




-(void)water_level{
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat: @"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"Water_Sensor1\"}",yuname,ypwd];
    
    NSLog(@" json req : %@",jsonInputString);
    
    NSURL *url = [NSURL URLWithString:@"https://jts-raju.in/service/get_sensor_data"];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 2: Create NSMutableRequest object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    
    
    // 3: Create Jsondata object
    NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Asynchronously Api is hit here
    NSURLSessionUploadTask *dataTask =
    [session uploadTaskWithRequest:request  fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
        
        
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:0
                                          error:nil];
        NSLog(@" sensor data %@", json);
        
        NSArray *water_Info=json[@"sensor_data"];
        for ( NSDictionary *sensorDAta in water_Info )
        {
            
            if (sensorDAta[@"water_level"] != sensorDAta[@"null_value"]){
                
                
                
                NSString *water_low_value = sensorDAta[@"lo_val_alert"];
                [[NSUserDefaults standardUserDefaults] setObject:water_low_value forKey:@"low_value"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSLog(@"low_value Data of water :  %@",water_low_value);
                
                
                NSString *water_high_value = sensorDAta[@"hi_val_alert"];
                [[NSUserDefaults standardUserDefaults] setObject:water_high_value forKey:@"high_value"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                NSLog(@"high value data of water %@",water_high_value);
                
                
                NSInteger water_level_01=[sensorDAta[@"water_level"] integerValue];
                
                
                
                if([sensorDAta[@"hi_val_alert"] isEqual:@"YES" ]){
                    
                    
                    
                    
                    NSLog(@"hi water alert playing audio .........");
                    
                    NSString *path = [[NSBundle mainBundle]                      pathForResource:@"hilevel" ofType:@"mp3"];
                    self->audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                                   [NSURL fileURLWithPath:path] error:NULL];
                    [self->audioPlayer play];
                    
                    
                }
                
                
                if([sensorDAta[@"lo_val_alert"] isEqual:@"YES" ]){
                    
                    NSLog(@"lo value alarm playing ..........");
                    
                    NSString *path = [[NSBundle mainBundle]  pathForResource:@"lolevel" ofType:@"mp3"];
                    self->audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:
                                   [NSURL fileURLWithPath:path] error:NULL];
                    [self->audioPlayer play];
                    
                }


                
                if(water_level_01<=10){
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.1 animated:YES];
                    });
                    NSLog(@"lo value not... alarm playing ..........");
                    
                    
                                   }
                else if(water_level_01<=20){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.2 animated:YES];
                    });                    NSLog(@"this is 20 value ");
                }
                
                
                else if(water_level_01<=30){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.3 animated:YES];
                    });                    NSLog(@"this is 30 value ");
                }
                
                
                else if(water_level_01<=40){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.4 animated:YES];
                    });                    NSLog(@"this is 40 value ");
                    
                    
                    
                }
                
                else if(water_level_01<=50){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.5 animated:YES];
                    });                    NSLog(@"this is 50 value ");
                }
                else if(water_level_01<=60){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.6 animated:YES];
                    });                    NSLog(@"this is 60 value ");
                    
                } 
                
                
                else if(water_level_01<=70){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.7 animated:YES];
                    });                    NSLog(@"this is 70 value ");
                }
                else if(water_level_01<=80){
                    
                    [self->audioPlayer stop];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.8 animated:YES];
                    });
                    NSLog(@"this is 80 value ");
                }
                

                
                
                //if([sensorDAta[@"water_level"] isEqual:@"100" ]){
                else if(water_level_01<=90){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)0.9 animated:YES];
                    });
                    
                    NSLog(@"hi value ...not playing ........");
            }
                
                
                
                else if(water_level_01<=100){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self->_water_var setProgress:(float)1.0 animated:YES];
                    });
                    
                    NSLog(@"hi value ...not playing ........");
                    
                    
                    
                }

                NSLog(@"water_level is a : %@", sensorDAta[@"water_level"] );
                
            }
            
            
            
        }
        
    }];
 
    [dataTask resume]; // Executed First
    
}

- (IBAction)alarmButAction:(id)sender {
    
    NSString *nsdata1=[[NSString alloc]init] ;
    
    [audioPlayer stop];
  
    NSUserDefaults *prefs32 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *water_low = [prefs32 stringForKey:@"low_value"];
    
    NSUserDefaults *prefs23 = [NSUserDefaults standardUserDefaults];
    // getting an NSString
    NSString *water_high = [prefs23 stringForKey:@"high_value"];
  
   // NSString *jsonInputString ;
    
    if([water_high isEqual:@"YES"]){
        
        
        nsdata1 =[[NSString alloc] initWithFormat: @"{\"username\": \"%@\", \"password\": \"%@\", \"sensor_id\":\"Water_Sensor1\",\"hi_alarm_reset\":\"reset\"}",yuname,ypwd];
        
        NSLog(@" this is %@",nsdata1);
  
        
    }
    
    if([water_low isEqual:@"YES"]){
        
        nsdata1 =[[NSString alloc] initWithFormat: @"{\"username\": \"%@\", \"password\": \"%@\", \"sensor_id\":\"Water_Sensor1\",\"lo_alarm_reset\":\"reset\"}",yuname,ypwd];
        
        
        NSLog(@"222222 %@",nsdata1);
        
    }
  
    NSURL *url = [NSURL URLWithString:@"https://jts-raju.in/service/reset_sensor_alert"];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    
    // 2: Create NSMutableRequest object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    
    
    
    // 3: Create Jsondata object
    
   NSData *jsonData = [nsdata1 dataUsingEncoding:NSUTF8StringEncoding];
    
    
    // Asynchronously Api is hit here
    NSURLSessionUploadTask *dataTask =
    [session uploadTaskWithRequest:request fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response,  NSError *error) {
        
        //NSLog(@"%@", data);
        
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:0
                                          error:nil];
        NSLog(@" stop %@", json);
        
        
        
        
    }];
    
    
    
    
    
    [dataTask resume]; // Executed First
    
    
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



// alert Change to grB1Light
- (IBAction)alertDoorButton:(id)sender {
    
   
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvDoor1Btn setImage:[UIImage imageNamed:@"lightbulbon.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm1TubeLight\", \"operation\": \"ON\"}",yuname ,ypwd];
        
        NSLog(@"555555555555 %@",jsonInputString);
        //NSString *jsonRequest = jsonInputString;
        
       NSURL *url = [NSURL URLWithString:rajuUrl];
        //NSURL *url=[NSURL URLWithString:@"https://jtaha.in/service/device"];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" @@@@@@@@@@ 1  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        [_fvDoor1Btn setImage:[UIImage imageNamed:@"bulboff.png"] forState:UIControlStateNormal];
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrBedRm1TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }

    
    
    
    

}



- (IBAction)alertLoginButton:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
    
    
}


// Group Switches

- (IBAction)shutAllGroupButton:(id)sender {
    
    
    
    NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAll\", \"operation\": \"ON\"}",yuname,ypwd];
   // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ShutAll\", \"operation\": \"ON\"}";
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" shutallllll  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
    
    
}


- (IBAction)leavingGroupButton:(id)sender {
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"LeavingRoom\", \"operation\": \"ON\"}",yuname,ypwd];
    
   // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"LeavingRoom\", \"operation\": \"ON\"}";
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@"  leaveeeeee  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
  
}

- (IBAction)sleepingGroupButton:(id)sender {
    
    
    NSString *jsonInputString=[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"Sleeping\", \"operation\": \"ON\"}",yuname,ypwd];
    
    
  //  NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"Sleeping\", \"operation\": \"ON\"}";
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
 
}

- (IBAction)watchTVGroupButton:(id)sender {
    
    
    NSString *jsonInputString= [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"WatchingTV\", \"operation\": \"ON\"}",yuname,ypwd];
    
   // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"WatchingTV\", \"operation\": \"ON\"}";
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" ttttttvvvvvvv %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
}




- (IBAction)Fan2FvButton:(id)sender {
    
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvFan2Btn setImage:[UIImage imageNamed:@"fanoff.png"] forState:UIControlStateNormal];
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"ON\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvFan2Btn setImage:[UIImage imageNamed:@"fanon.png"] forState:UIControlStateNormal];
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallFan\", \"operation\": \"OFF\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 5555555  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
}


- (IBAction)Fan1FvButton:(id)sender {
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvFan1Btn setImage:[UIImage imageNamed:@"fanoff.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString= [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"ON\"}",yuname,ypwd];
        //NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"ON\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvFan1Btn setImage:[UIImage imageNamed:@"fanon.png"] forState:UIControlStateNormal];
        
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1Fan\", \"operation\": \"OFF\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@"%@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
}


- (IBAction)Light4FvButton:(id)sender {
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvLight4Btn setImage:[UIImage imageNamed:@"lightbulbon.png"] forState:UIControlStateNormal];
        
       
        
        NSString *jsonInputString= [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"ON\"}",yuname,ypwd];
        
       // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"ON\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvLight4Btn setImage:[UIImage imageNamed:@"bulboff.png"] forState:UIControlStateNormal];
        
        NSString *jsonInputString = [[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"OFF\"}",yuname,ypwd];
       // NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallDownLight1\", \"operation\": \"OFF\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
    
}



- (IBAction)Light2FvButton:(id)sender {
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvLight2Btn setImage:[UIImage imageNamed:@"lightbulbon.png"] forState:UIControlStateNormal];
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight1\", \"operation\": \"ON\"}",yuname,ypwd];
        //NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight1\", \"operation\": \"ON\"}";
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        [_fvLight2Btn setImage:[UIImage imageNamed:@"bulboff.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingLight1\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
}


- (IBAction)fvb1LightButton:(id)sender {
    
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
      
        [_fvB1LightBtn setImage:[UIImage imageNamed:@"lightbulbon.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1TubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvB1LightBtn setImage:[UIImage imageNamed:@"bulboff.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm1TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
    }
    
    
    
}

- (IBAction)fvb2FanButton:(id)sender {
    
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        
        [_fvFan3Btn setImage:[UIImage imageNamed:@"fanoff.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Fan\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvFan3Btn setImage:[UIImage imageNamed:@"fanon.png"] forState:UIControlStateNormal];
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2Fan\", \"operation\": \"OFF\"}"];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
}


- (IBAction)fvgrCurtainUpButton:(id)sender {
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallCurtainUp\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
}

- (IBAction)fvgrCurtainDownButton:(id)sender {
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"GrdFlrHallCurtainDown\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
}

- (IBAction)fvfstCurtainUpButton:(id)sender {
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallCurtainUp\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
}

- (IBAction)fvfstCurtainDownButton:(id)sender {
    
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrHallCurtainDown\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
}




- (IBAction)Light1FvButton:(id)sender {
    
    if(self.isOnOff)
    {
        self.isOnOff=NO;
        [_fvLight1Btn setImage:[UIImage imageNamed:@"lightbulbon.png"] forState:UIControlStateNormal];
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2TubeLight\", \"operation\": \"ON\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
        
        
    }
    //else if ([doorBtn1.currentTitle isEqualToString:@"Close"])
    else{
        self.isOnOff=YES;
        
        [_fvLight1Btn setImage:[UIImage imageNamed:@"bulboff.png"] forState:UIControlStateNormal];
    
        
        
        
        NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"FrstFlrBedRm2TubeLight\", \"operation\": \"OFF\"}",yuname,ypwd];
        
        //NSString *jsonRequest = jsonInputString;
        
        NSURL *url = [NSURL URLWithString:rajuUrl];
        
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        //
        

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
            NSLog(@" 777777  %@ ", json);
            //access(json,data);
        }];
        
        [dataTask resume]; // Executed First
        
        
        
        
    }
    
    
    
    
}


- (IBAction)groundD1Button:(id)sender {
    
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingDoor1\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

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
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
    [dataTask resume]; // Executed First
    
    
    
    
    
}

- (IBAction)groundD2Button:(id)sender {
    
    
    NSString *jsonInputString =[[NSString alloc] initWithFormat:@"{\"username\": \"%@\", \"password\": \"%@\", \"switch_id\": \"ParkingDoor2\", \"operation\": \"ON\"}",yuname,ypwd];
    
    //NSString *jsonRequest = jsonInputString;
    
    NSURL *url = [NSURL URLWithString:rajuUrl];
    
    NSURLSessionConfiguration *config =
    [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //
    

    // 2: Create NSMutableRequest object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
    
    

    
    request.HTTPMethod = @"POST";
    //NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    // 3: Create Jsondata object
   // //NSError *error = nil;
    NSData *jsonData = [jsonInputString dataUsingEncoding:NSUTF8StringEncoding];
    
   // Asynchronously Api is hit here
    NSURLSessionUploadTask *dataTask =
    [session uploadTaskWithRequest:request                        fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        
        
        
        
        //NSLog(@"%@", data);
        
        NSDictionary *json =
        [NSJSONSerialization JSONObjectWithData:data                                        options:0 error:nil];
        NSLog(@" 777777  %@ ", json);
        //access(json,data);
    }];
    
   
    
    [dataTask resume]; // Executed First
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
