//
//  RequestToApi.h
//  comTracks8
//
//  Created by local on 1/28/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestToApi : NSObject
@property (nonatomic, strong) NSMutableString *artistNameReadyForApi;
@property (nonatomic, strong) NSArray* artistMixes;
- (void)EighttracksMixSearch: (NSString *)artistString;
-(void)showTrending;
@end
