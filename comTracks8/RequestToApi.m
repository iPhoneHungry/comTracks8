//
//  RequestToApi.m
//  comTracks8
//
//  Created by local on 1/28/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import "RequestToApi.h"

@implementation RequestToApi
@synthesize artistNameReadyForApi;
@synthesize artistMixes;



#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

- (void)EighttracksMixSearch:(NSString *)artistString{
    NSLog(@"new search");
    NSString *appKey = @"177657ad94e2ec945a0330e11d2383b44b1dbb99";
    NSString *url = [NSString stringWithFormat:@"http://8tracks.com/mixes.json?q=%@?api_key=%@", artistString,appKey];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL    *urlToRequest     =   [[NSURL alloc]initWithString:url];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        urlToRequest];
        [self performSelectorOnMainThread:@selector(eightTracksfetchedData:)
                               withObject:data waitUntilDone:YES]; });
    
}



- (void)eightTracksfetchedData:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions error:&error];
    artistMixes = [json objectForKey:@"mixes"];
 //   NSDictionary *mixesParse = [NSDictionary dicti]
    NSLog(@"%ld",(unsigned long)artistMixes.count);
    NSDictionary *mixDetails = [[NSDictionary alloc] init];
   mixDetails = [NSDictionary dictionaryWithObject:artistMixes forKey:@"mixArray"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"Mix Data Recvd" object:self userInfo:mixDetails];
   
 
    NSLog(@"artist :::: %@",[json objectForKey:@"name"]);
}

-(void)showTrending {
    
    
    NSLog(@"loading trending mixes");
    NSString *appKey = @"177657ad94e2ec945a0330e11d2383b44b1dbb99";
    NSString *url = [NSString stringWithFormat:@"http://8tracks.com/mix_sets/all.json?include=mixes?api_key=%@",appKey];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL    *urlToRequest     =   [[NSURL alloc]initWithString:url];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        urlToRequest];
        [self performSelectorOnMainThread:@selector(eightTracksfetchedData:)
                               withObject:data waitUntilDone:YES]; });
    

}


@end
