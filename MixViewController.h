//
//  MixViewController.h
//  comTracks8
//
//  Created by local on 1/30/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MixViewController : NSObject

 @property (strong) IBOutlet NSArrayController *mixArrayCntrllr;

@property (strong) NSMutableArray *mixesArray;
-(void)receivedMixData:(NSNotification *)mixDataNotify;

@end
