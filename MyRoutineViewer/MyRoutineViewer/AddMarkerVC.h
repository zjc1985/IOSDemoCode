//
//  AddMarkerVC.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoutineManager.h"

@interface AddMarkerVC : UIViewController

@property(nonatomic,strong)Routine *belongRoutine;
@property(nonatomic,strong)RoutineManager *manager;

@end
