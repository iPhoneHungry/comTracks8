//
//  MixViewController.h
//  comTracks8
//
//  Created by local on 1/30/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RequestToApi.h"

@interface MixViewController : NSObject
@property (weak) IBOutlet NSProgressIndicator *loadProgressImg;

@property (strong) RequestToApi *mixApiRequest;
@property (strong) IBOutlet NSArrayController *mixArrayCntrllr;
@property (strong) IBOutlet NSSearchField *artistSearchBox;
@property (strong) NSMutableArray *mixesArray;


-(void)receivedMixData:(NSNotification *)mixDataNotify;

-(IBAction)searchfieldDone:(id)sender;
@end
