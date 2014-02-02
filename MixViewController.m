//
//  MixViewController.m
//  comTracks8
//
//  Created by local on 1/30/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import "MixViewController.h"
#import "MixData.h"
#import "RequestToApi.h"

@interface MixViewController ()
@end

@implementation MixViewController
@synthesize mixesArray = _mixesArray;
@synthesize mixArrayCntrllr;


-(void)awakeFromNib {
     _mixesArray = [[NSMutableArray alloc] init];
    
    RequestToApi *testRequest = [[RequestToApi alloc] init];
    [testRequest EighttracksMixSearch:[NSString stringWithFormat:@"nin"]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedMixData:)
                                                 name:@"Mix Data Recvd"
                                               object:nil];
    
   
}


-(void)receivedMixData:(NSNotification *)mixDataNotify{
    
    NSArray  *mixDataArray = [[mixDataNotify userInfo] objectForKey:@"mixArray"];
    NSDictionary *mixesData = [[NSDictionary alloc] init];
    
    mixesData = [mixDataNotify userInfo];
    NSLog(@"trtrtr   %@",mixesData);
    int x = 0;
    for (id object in mixDataArray) {
        
    
       
    //NSLog(@"%ld",(unsigned long)mixDataArray.count);
        
        NSDictionary  *objectDict = [[NSDictionary alloc] init];
        objectDict = object;
        
        MixData *mixObject = [[MixData alloc] init];
        mixObject.mixName = [objectDict objectForKey:@"name"];
        mixObject.mixImgUrl = [NSURL URLWithString:[[objectDict objectForKey:@"cover_urls"] objectForKey:@"sq100"]] ;
      
       // NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
       
    //mixObject.mixRating = 3.0;
     //  NSLog(@"%@",mixObject.mixName);
    
    [self.mixesArray addObject:mixObject];
        NSLog(@"%d",x);
         x++;
    }
    [mixArrayCntrllr addObjects:_mixesArray];
   // NSLog(@"array added to controller");
    
}

@end
