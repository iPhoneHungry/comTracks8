//
//  RequestToApi.h
//  comTracks8
//
//  Created by local on 1/28/14.
//  Copyright (c) 2014 rezand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestToApi : NSObject {
    NSString *appKey;
}
@property (nonatomic, strong) NSMutableString *artistNameReadyForApi;
@property (nonatomic, strong) NSArray* artistMixes;
@property (nonatomic, strong) NSArray* mixToPlayData;
- (void)EighttracksMixSearch: (NSString *)artistString;
-(void)showTrending;
-(void)mixIdtoFetch:(NSNotification *)urlID;
@end
