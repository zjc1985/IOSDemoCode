//
//  Routine.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Marker;

@interface Routine : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSSet *markers;
@end

@interface Routine (CoreDataGeneratedAccessors)

- (void)addMarkersObject:(Marker *)value;
- (void)removeMarkersObject:(Marker *)value;
- (void)addMarkers:(NSSet *)values;
- (void)removeMarkers:(NSSet *)values;

@end
