//
//  AddMarkerVC.m
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "AddMarkerVC.h"

@interface AddMarkerVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *markerTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *markerImgUrlsTextView;

@end

@implementation AddMarkerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"addMarkerDoneSegue"]){
        Marker *marker=[self.manager createMarkerInRoutine:self.belongRoutine];
        marker.title=self.markerTitleLabel.text;
        marker.imgUrls=self.markerImgUrlsTextView.text;
        NSLog(@"%@ %@",marker.title,marker.imgUrls);
    }
}


@end
