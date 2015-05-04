//
//  MarkerTVCTableViewController.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoutineManager.h"
#import "AVCloudManager.h"

@interface MarkerTVC : UITableViewController

@property(nonatomic,strong)Routine *routine;
@property(nonatomic,strong)RoutineManager *dbManager;
@property(nonatomic,strong)AVCloudManager *avManager;

@end
