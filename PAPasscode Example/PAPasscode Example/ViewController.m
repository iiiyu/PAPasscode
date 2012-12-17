//
//  ViewController.m
//  PAPasscode Example
//
//  Created by Denis Hennessy on 15/10/2012.
//  Copyright (c) 2012 Peer Assembly. All rights reserved.
//

#import "ViewController.h"


#define degreesToRadians(x) (M_PI*(x)/180.0)

@interface ViewController ()

@end

@implementation ViewController

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view = self.portraitView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view = self.landscapeView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.view = self.landscapeView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    }
    
}

- (IBAction)setPasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
//        passcodeViewController.backgroundView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
//        passcodeViewController.backgroundView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];// = [UIImage imageNamed:@""];
        passcodeViewController.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"papasscode_marker.png"]];
    }
    passcodeViewController.delegate = self;
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)enterPasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        passcodeViewController.backgroundView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = _passcodeLabel.text;
    passcodeViewController.alternativePasscode = @"9999";
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (IBAction)changePasscode:(id)sender {
    PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionChange];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        passcodeViewController.backgroundView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    passcodeViewController.delegate = self;
    passcodeViewController.passcode = _passcodeLabel.text;
    passcodeViewController.simple = _simpleSwitch.on;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterAlternativePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Alternative Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Passcode entered correctly" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        _passcodeLabel.text = controller.passcode;
    }];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        _passcodeLabel.text = controller.passcode;
    }];
}

- (void)viewDidUnload {
    [self setSimpleSwitch:nil];
    [self setPortraitView:nil];
    [self setLandscapeView:nil];
    [super viewDidUnload];
}
@end
