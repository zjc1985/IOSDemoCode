//
//  RoutineManager.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Routine.h"
#import "Marker.h"

@interface RoutineManager : NSObject

+(instancetype)sharedManager;

-(Routine *)createRoutineWithTitle:(NSString *)title;
-(Routine *)createRoutineWithTitle:(NSString *)title withUUID:(NSString *)uuid;
-(Routine *)queryRoutineWithUUID:(NSString *)uuid;
-(void)removeRoutine:(Routine *)routine;
-(NSArray *)getAllRoutine;

-(Marker *)createMarkerInRoutine:(Routine *)routine;
-(Marker *)createMarkerInRoutine:(Routine *)routine withUUID:(NSString *)uuid;
-(void)removeMarker:(Marker *)marker;
-(Marker *)fetchMarkerByUUID:(NSString *)uuid;

-(BOOL)saveChanges;

@end
