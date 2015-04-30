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
-(void)removeRoutine:(Routine *)routine;
-(NSArray *)getAllRoutine;

-(Marker *)createMarkerInRoutine:(Routine *)routine;
-(void)removeMarker:(Marker *)marker;

-(BOOL)saveChanges;

@end
