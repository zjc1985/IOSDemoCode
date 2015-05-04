//
//  MarkerTVCTableViewController.m
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "MarkerTVC.h"
#import "MarkerTableViewCell.h"
#import "AddMarkerVC.h"
#import "FSBasicImage.h"
#import <FSBasicImageSource.h>
#import "FSImageViewerViewController.h"
#import "Marker+MarkerExtension.h"

@interface MarkerTVC ()<AVCloudManagerDelegate>

@end

@implementation MarkerTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(startToFetchCloudData) forControlEvents:UIControlEventValueChanged];
    [self startToFetchCloudData];
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)startToFetchCloudData{
    [self.refreshControl beginRefreshing];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.avManager startToFetchMarkersByRoutine:self.routine usingBlockWhenDone:^(NSError *error) {
        [self.refreshControl endRefreshing];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if(!error){
            NSLog(@"start to refresing markers");
            [self.tableView reloadData];
        }else{
            NSLog(@"net work not working");
        }
    }];
   
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.routine.markers allObjects] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MarkerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"markerTableCell" forIndexPath:indexPath];
    
    Marker *marker=[self.routine.markers allObjects][indexPath.row];
    
    //NSLog(@"row %u title %@ imagUrls %@ uuid %@",indexPath.row,marker.title,marker.imgUrls,marker.uuid);
    
    cell.markerTitle.text=marker.title;
    cell.markerSubTitle.text=marker.imgUrls;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Marker *marker=[self.routine.markers allObjects][indexPath.row];
    NSArray *imageUrlArray= [marker getImageUrlsArray];
    //NSLog(@"%@",marker.imgUrls);
    
    NSMutableArray *images=[[NSMutableArray alloc]init];
    if(imageUrlArray && [imageUrlArray count]>0){
        NSLog(@"image num: %u",[imageUrlArray count]);
        for (NSString *imageUrl in imageUrlArray) {
            NSString *urlString=[imageUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            FSBasicImage *image=[[FSBasicImage alloc]initWithImageURL:[NSURL URLWithString:urlString]];
            [images addObject:image];
        }
        
        FSBasicImageSource *source=[[FSBasicImageSource alloc]initWithImages:[NSArray arrayWithArray:images]];
        
        FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:source];
        
        [self.navigationController pushViewController:imageViewController animated:YES];
    }
    
   
    
    /*
    NSMutableArray *urls=[[NSMutableArray alloc]init];
    [urls addObject:@"http://file27.mafengwo.net/M00/31/78/wKgB6lQEWGuAPyk1ABr7FxM7ugU32.jpeg"];
    [urls addObject:@"http://file27.mafengwo.net/M00/32/96/wKgB6lQEWeiARy-GAAY0duJ5qDw58.groupinfo.w600.jpeg"];
    
    NSMutableArray *images=[[NSMutableArray alloc]init];
    for (NSString * urlString in urls) {
        FSBasicImage *image=[[FSBasicImage alloc]initWithImageURL:[NSURL URLWithString:urlString]];
        [images addObject:image];
    }
    
    FSBasicImageSource *source=[[FSBasicImageSource alloc]initWithImages:images];
    
    FSImageViewerViewController *imageViewController = [[FSImageViewerViewController alloc] initWithImageSource:source];
    [self.navigationController pushViewController:imageViewController animated:YES];
    */
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
    if([segue.destinationViewController isKindOfClass:[AddMarkerVC class]]){
        AddMarkerVC *addMarkerVC=segue.destinationViewController;
        addMarkerVC.belongRoutine=self.routine;
        addMarkerVC.manager=self.dbManager;
    }
}

-(IBAction)addMarkerDone:(UIStoryboardSegue *)segue{
    [self.tableView reloadData];
}


@end
