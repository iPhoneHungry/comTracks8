//
//  MixData.h
//  comTracks8
//
//  Created by local on 1/30/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MixData : NSObject

@property (strong) NSString * mixID;
@property (strong) NSString * tmpUrlString;
@property NSURL *mixImgUrl;
@property (strong) NSString *mixName;
@property float mixRating;

-(IBAction)playThisMix:(id)sender;

-(void)setImgUrl:(NSString *)urlString;
-(void)setImgUrlDefault;
@end
