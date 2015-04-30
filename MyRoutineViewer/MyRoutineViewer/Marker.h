//
//  Marker.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Routine;

@interface Marker : NSManagedObject

@property (nonatomic, retain) NSString * imgUrls;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) Routine *belongRoutine;

@end
