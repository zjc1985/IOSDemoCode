//
//  AddRoutineVCViewController.m
//  MyRoutineViewer
//
//  Created by bizappman on 4/30/15.
//  Copyright (c) 2015 yufu. All rights reserved.
//

#import "AddRoutineVC.h"


@interface AddRoutineVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;

@end

@implementation AddRoutineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AddRoutineDoneSegue"]){
        [self.manager createRoutineWithTitle:self.titleLabel.text];
    }
}

@end
