//
//  RoutineManager.m
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "RoutineManager.h"
#import "AppDelegate.h"
@import CoreData;

@interface RoutineManager()

@property(nonatomic,strong)NSManagedObjectContext *context;

@end

@implementation RoutineManager

#pragma marker - getters and setters
-(NSManagedObjectContext *)context{
    if(!_context){
        AppDelegate *appDelegate=[UIApplication sharedApplication].delegate;
        _context=[appDelegate managedObjectContext];
    }
    return _context;
}

#pragma mark - singleton init

+(instancetype)sharedManager{
    static RoutineManager *manager;
    if(!manager){
       manager=[[self alloc] initPrivate];
    }
    return manager;
}

-(instancetype)initPrivate{
    self=[super init];
    if(self){
    }
    return self;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[RoutineManager sharedManager]"
                                 userInfo:nil];
    return nil;
}

#pragma mark - public method

-(NSArray *)getAllRoutine{
    NSFetchRequest *request=[[NSFetchRequest alloc]init];
    NSEntityDescription *e=[NSEntityDescription entityForName:@"Routine"
                                       inManagedObjectContext:self.context];
    request.entity=e;
    NSSortDescriptor *sd=[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    request.sortDescriptors=@[sd];
    NSError *error;
    NSArray *result=[self.context executeFetchRequest:request error:&error];
    if(!result){
        [NSException raise:@"Fetch failed"
                    format:@"Reason: %@", [error localizedDescription]];
    }
    
    return result;
}

-(Routine *)createRoutineWithTitle:(NSString *)title{
    Routine *routine=[NSEntityDescription insertNewObjectForEntityForName:@"Routine"
                                                   inManagedObjectContext:self.context];
    routine.title=title;
    NSUUID *uuid=[[NSUUID alloc]init];
    routine.uuid=[uuid UUIDString];
    return routine;
}

-(void)removeRoutine:(Routine *)routine{
    [self.context deleteObject:routine];
}

-(Marker *)createMarkerInRoutine:(Routine *)routine{
    Marker *marker=[NSEntityDescription insertNewObjectForEntityForName:@"Marker"
                                                 inManagedObjectContext:self.context];
    NSUUID *uuid=[[NSUUID alloc]init];
    marker.uuid=[uuid UUIDString];
    marker.belongRoutine=routine;
    //[routine addMarkersObject:marker];
    return marker;
}

-(void)removeMarker:(Marker *)marker{
    [self.context deleteObject:marker];
}

- (BOOL)saveChanges
{
    NSError *error;
    BOOL successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}
















@end
