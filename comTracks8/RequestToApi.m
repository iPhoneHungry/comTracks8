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
@synthesize mixToPlayData;

#define kBgQueue dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

-(id)init{
    
    
    self = [super init];
    if (self) {
        appKey = @"177657ad94e2ec945a0330e11d2383b44b1dbb99";

        [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(mixIdtoFetch:)
    name:@"fetchIDfromURL"
    object:nil];
    }
    return self;
}

- (void)EighttracksMixSearch:(NSString *)artistString{
    NSLog(@"new search");
   
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
    NSDictionary *mixDetails;
   mixDetails = [NSDictionary dictionaryWithObject:artistMixes forKey:@"mixArray"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"Mix Data Recvd" object:self userInfo:mixDetails];
   
 
    NSLog(@"artist :::: %@",[json objectForKey:@"name"]);
}

-(void)showTrending {
    
    
    NSLog(@"loading trending mixes");

    NSString *url = [NSString stringWithFormat:@"http://8tracks.com/mix_sets/all.json?include=mixes?api_key=%@",appKey];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL    *urlToRequest     =   [[NSURL alloc]initWithString:url];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        urlToRequest];
        [self performSelectorOnMainThread:@selector(eightTracksfetchedData:)
                               withObject:data waitUntilDone:YES]; });
    

}

-(void)mixIdtoFetch:(NSNotification *)urlIDnotify {
    
    NSString *urlID = [[urlIDnotify userInfo] objectForKey:@"idToFetch"];
   
   
    NSString *url = [NSString stringWithFormat:@"http://8tracks.com/sets/111696185/play.json?mix_id=%@?api_key=%@",urlID,appKey];
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL    *urlToRequest     =   [[NSURL alloc]initWithString:url];
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        urlToRequest];
        [self performSelectorOnMainThread:@selector(mixDataReady:)
                               withObject:data waitUntilDone:YES]; });
    
    
}

- (void)mixDataReady:(NSData *)responseData {
    NSError *error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions error:&error];
     mixToPlayData = [json objectForKey:@"set"];
    [self playMix:[[[json objectForKey:@"set"] objectForKey:@"track"] objectForKey:@"url"]];
    //   NSDictionary *mixesParse = [NSDictionary dicti]

    
    
}

-(void)playMix:(NSString *)urlStringToPlay
{
NSLog(@"api play mix request");
NSDictionary * mixUrlDict = [NSDictionary dictionaryWithObject:urlStringToPlay forKey:@"urlString"];
NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
[center postNotificationName:@"Play Mix" object:self userInfo:mixUrlDict];
}
@end
