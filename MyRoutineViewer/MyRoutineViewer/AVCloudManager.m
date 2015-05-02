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
