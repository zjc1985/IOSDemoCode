//
//  AVCloudManager.m
//  MyRoutineViewer
//
//  Created by yufu on 15/5/2.
//  Copyright (c) 2015年 yufu. All rights reserved.
//

#import "AVCloudManager.h"

@interface AVCloudManager()

@property(nonatomic,strong)RoutineManager *dbManager;

@end



@implementation AVCloudManager

-(RoutineManager *)dbManager{
    if(!_dbManager){
        _dbManager=[RoutineManager sharedManager];
    }
    return _dbManager;
}

-(void)startToFetchMarkersByRoutine:(Routine *)routine usingBlockWhenDone:(void (^)(NSError *error))block{
    AVQuery *query=[AVQuery queryWithClassName:@"Marker"];
    [query whereKey:@"routineId" equalTo:routine.uuid];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"Successfully retrieved %d markers.", objects.count);
            
            for (AVObject *eachMarker in objects) {
                NSString *uuid=[eachMarker objectForKey:@"uuid"];
                NSString *title=[eachMarker objectForKey:@"title"];
                NSString *imgUrls=[eachMarker objectForKey:@"imgUrls"];
                
                Marker *marker=[self.dbManager fetchMarkerByUUID:uuid];
                if(!marker){
                    marker=[self.dbManager createMarkerInRoutine:routine withUUID:uuid];
                }
                
                marker.title=title;
                marker.imgUrls=imgUrls;
            }
            
        }
        block(error);
    }];

}

-(void)startToFetchMarkersByRoutine:(Routine *)routine{
    AVQuery *query=[AVQuery queryWithClassName:@"Marker"];
    [query whereKey:@"routineId" equalTo:routine.uuid];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"Successfully retrieved %d markers.", objects.count);
            
            for (AVObject *eachMarker in objects) {
                NSString *uuid=[eachMarker objectForKey:@"uuid"];
                NSString *title=[eachMarker objectForKey:@"title"];
                NSString *imgUrls=[eachMarker objectForKey:@"imgUrls"];
                
                Marker *marker=[self.dbManager fetchMarkerByUUID:uuid];
                if(!marker){
                    marker=[self.dbManager createMarkerInRoutine:routine withUUID:uuid];
                }
                
                marker.title=title;
                marker.imgUrls=imgUrls;
                
                if([self.delegate respondsToSelector:@selector(fetchMarkersDone)]){
                    [self.delegate fetchMarkersDone];
                }
            }
        
        }else{
            if([self.delegate respondsToSelector:@selector(fetchMarkersFail)]){
                [self.delegate fetchMarkersFail];
            }
        }
    }];
}

-(void)startToFetchAllRoutines{
    AVQuery *query=[AVQuery queryWithClassName:@"Routine"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d routines.", objects.count);
            
            for (AVObject *eachRoutine in objects) {
                NSString *title=[eachRoutine objectForKey:@"title"];
                NSString *uuid=[eachRoutine objectForKey:@"uuid"];
                NSDate *date=eachRoutine.updatedAt;
                NSLog(@"routine title:%@ ,uuid:%@, updateDate:%@",title,uuid,[date description]);
                
                Routine *routine=[self.dbManager queryRoutineWithUUID:uuid];
                if(!routine){
                    [self.dbManager createRoutineWithTitle:title withUUID:uuid];
                }
                
                if([self.delegate respondsToSelector:@selector(fetchAllRoutinesDone)]){
                    [self.delegate fetchAllRoutinesDone];
                }
            }
            
        } else {
            if([self.delegate respondsToSelector:@selector(fetchAllRoutinesError)]){
                [self.delegate fetchAllRoutinesError];
            }
        }
    }];
}

@end
