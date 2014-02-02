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


-(id) init  {
    self = [super init];
    if (self) {
       _mixName = @"Loading Mix";
        _mixRating = 4.0;
    }
    return self;
}

@end
