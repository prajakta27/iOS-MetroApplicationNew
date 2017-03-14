//
//  RouteInfoViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "RouteInfoViewController.h"
#import "APIPackets.h"
#import "APIFile.h"
#import "DataObjectFile.h"

@interface RouteInfoViewController ()
{
    NSMutableArray *arr;
    //NSMutableDictionary *dic;
}

@end

@implementation RouteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.fareTextLabel.text = self.fareTextStr;
    self.fromTextLabel.text = self.fromStr;
    self.toTextLabel.text = self.toStr;
    self.distanceTextLabel.text = self.distanceTextStr;
    self.timeTextLabel.text = self.timeTextStr;
    self.stationsInBetweenTextLabel.text = self.stationsInBetweenTextStr;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
