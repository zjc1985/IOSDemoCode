//
//  RoutineTVC.m
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "RoutineTVC.h"
#import "RoutineManager.h"
#import "SubTitleTableViewCell.h"
#import "AddRoutineVC.h"
#import "MarkerTVC.h"
#import "AVCloudManager.h"

@interface RoutineTVC ()<AVCloudManagerDelegate>

@property(nonatomic,strong)RoutineManager *routineManager;
@property(nonatomic,strong)AVCloudManager *avManager;

@end

@implementation RoutineTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.leftBarButtonItem=self.editButtonItem;
    
    self.avManager.delegate=self;
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"routineTVC will appear");
    
    [self.tableView reloadData];
    [self.avManager startToFetchAllRoutines];
}

#pragma mark - getters and setters
-(RoutineManager *)routineManager{
    if(!_routineManager){
        _routineManager=[RoutineManager sharedManager];
    }
    return _routineManager;
}

-(AVCloudManager *)avManager{
    if(!_avManager){
        _avManager=[[AVCloudManager alloc]init];
    }
    return _avManager;
}

#pragma mark - av cloud delgate
-(void)fetchAllRoutinesDone{
    NSLog(@"net work fetchh all routine done");
    [self.tableView reloadData];
}


#pragma mark - ui action

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Routine *routine=[self.routineManager getAllRoutine][indexPath.row];
    
    [self performSegueWithIdentifier:@"markerSegue" sender:routine];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.routineManager getAllRoutine] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"subTitleTableCell" forIndexPath:indexPath];
    
    Routine *routine=[self.routineManager getAllRoutine][indexPath.row];
    
    
    cell.titleLabel.text=routine.title;
    cell.subTitleLabel.text=[NSString stringWithFormat:@"%u",[routine.markers count]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Routine *routine=[self.routineManager getAllRoutine][indexPath.row];
        [self.routineManager removeRoutine:routine];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[AddRoutineVC class]]){
        AddRoutineVC *addRoutinevc=segue.destinationViewController;
        addRoutinevc.manager=self.routineManager;
    }
    
    if([segue.identifier isEqualToString:@"markerSegue"]){
        MarkerTVC *markerTVC=segue.destinationViewController;
        markerTVC.manager=self.routineManager;
        markerTVC.routine=sender;
    }
}

-(IBAction)AddRoutineDone:(UIStoryboardSegue *)segue{
    [self.tableView reloadData];
}

@end
