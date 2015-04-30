//
//  MarkerTableViewCell.h
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "SubTitleTableViewCell.h"

@interface MarkerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *markerTitle;

@property (weak, nonatomic) IBOutlet UILabel *markerSubTitle;
@end
