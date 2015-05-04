//
//  AVCloudManager.h
//  MyRoutineViewer
//
//  Created by yufu on 15/5/2.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>
#import "RoutineManager.h"

@protocol AVCloudManagerDelegate <NSObject>

@optional
-(void)fetchAllRoutinesDone;
-(void)fetchAllRoutinesError;

-(void)fetchMarkersDone;
-(void)fetchMarkersFail;

@end


@interface AVCloudManager : NSObject

@property(nonatomic,weak)id <AVCloudManagerDelegate> delegate;

-(void)startToFetchAllRoutines;

-(void)startToFetchMarkersByRoutine:(Routine *)routine;

-(void)startToFetchMarkersByRoutine:(Routine *)routine usingBlockWhenDone:(void (^)(NSError *error))block;

@end

