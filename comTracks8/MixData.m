//
//  MixData.m
//  comTracks8
//
//  Created by local on 1/30/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import "MixData.h"

@implementation MixData
@synthesize mixName = _mixName;
@synthesize mixImgUrl;
@synthesize tmpUrlString;


-(id) init  {
    self = [super init];
    if (self) {
       _mixName = @"Loading Mix";
        _mixRating = 4.0;
       mixImgUrl = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/en/4/47/Tcpmp-betaplayer-01-100x100.png"];
    }
    return self;
}




@end
