//
//  SelectedStationDetailViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "SelectedStationDetailViewController.h"
#import "TimingsAnimationViewController.h"
#import "FrequencyAnimationViewController.h"
#import "ParkingAnimationViewController.h"
#import "ContactAnimationViewController.h"

@interface SelectedStationDetailViewController ()
{
    UIButton *trainTimingsBtn;
    UIButton *parkingBtn;
    UIButton *trainFrequencyBtn;
    UIButton *contactInfoBtn;
    
}

@end

@implementation SelectedStationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
       [self.backBtn setUserInteractionEnabled:YES];
    [self detailScreen];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) detailScreen
{
    
    CGFloat viewWidth =  self.view.frame.size.width;
    CGFloat btnWidth =  self.view.frame.size.width-20;
    CGFloat buttonHeight  = 50;
    
    UIView *headLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, viewWidth, 35)];
    UILabel *headLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headLabelView.frame.size.width, 21)];
    [headLbl setTextAlignment:NSTextAlignmentCenter];
    headLbl.text = [NSString stringWithFormat:@"%@",self.selectedStationName];
    [headLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16]];
    [headLbl setTextColor:[UIColor purpleColor]];
    [self.view addSubview:headLabelView];
    [headLabelView addSubview:headLbl];
    
    
    UIView *fromToLabel = [[UIView alloc] initWithFrame:CGRectMake(0, headLabelView.frame.origin.y + headLabelView.frame.size.height+10, viewWidth, 35)];
    UILabel *toLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fromToLabel.frame.size.width, 21)];
    [toLabel setTextAlignment:NSTextAlignmentCenter];
    [toLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16]];
    toLabel.text = [NSString stringWithFormat:@"%@ to M. G. Road",self.selectedStationName];
    [self.view addSubview:fromToLabel];
    [fromToLabel addSubview:toLabel];
    
    
    trainTimingsBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, fromToLabel.frame.origin.y + fromToLabel.frame.size.height+30, btnWidth , buttonHeight)];
    [trainTimingsBtn setTitle:@"  Timings" forState:UIControlStateNormal];
    [trainTimingsBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    trainTimingsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [trainTimingsBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    [self shadowBtn:trainTimingsBtn];
    [trainTimingsBtn addTarget:self action:@selector(trainTimingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trainTimingsBtn];
    
    parkingBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, trainTimingsBtn.frame.origin.y + trainTimingsBtn.frame.size.height+10, btnWidth , buttonHeight)];
    [parkingBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [parkingBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    [parkingBtn setTitle:@"  Parking" forState:UIControlStateNormal];
    [parkingBtn addTarget:self action:@selector(parkingAction:) forControlEvents:UIControlEventTouchUpInside];
    parkingBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self shadowBtn:parkingBtn];
    [self.view addSubview:parkingBtn];
    
    trainFrequencyBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, parkingBtn.frame.origin.y + parkingBtn.frame.size.height+10, btnWidth , buttonHeight)];
    [trainFrequencyBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [trainFrequencyBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    [trainFrequencyBtn setTitle:@"  Train Frequency" forState:UIControlStateNormal];
    trainFrequencyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self shadowBtn:trainFrequencyBtn];
    [trainFrequencyBtn addTarget:self action:@selector(trainFrequencyAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:trainFrequencyBtn];
    
    contactInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, trainFrequencyBtn.frame.origin.y + trainFrequencyBtn.frame.size.height+10, btnWidth , buttonHeight)];
    [contactInfoBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [contactInfoBtn.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14]];
    [contactInfoBtn setTitle:@"  Contact Info" forState:UIControlStateNormal];
    contactInfoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [contactInfoBtn addTarget:self action:@selector(contactInfoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self shadowBtn:contactInfoBtn];
    [self.view addSubview:contactInfoBtn];
    
}

-(IBAction)trainTimingAction:(id)sender
{
    TimingsAnimationViewController *timingsAnimationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimingAnimationVC"];
    timingsAnimationVC.transitioningDelegate = self;
    timingsAnimationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:timingsAnimationVC animated:YES completion:nil];
}

-(IBAction)parkingAction:(id)sender
{
    ParkingAnimationViewController *parkingAnimationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ParkingAnimationVC"];
    parkingAnimationVC.transitioningDelegate = self;
    parkingAnimationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:parkingAnimationVC animated:YES completion:nil];
}

-(IBAction)trainFrequencyAction:(id)sender
{
    FrequencyAnimationViewController *frequencyAnimationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FrequencyAnimationVC"];
    frequencyAnimationVC.transitioningDelegate = self;
    frequencyAnimationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:frequencyAnimationVC animated:YES completion:nil];
}

-(IBAction)contactInfoAction:(id)sender
{
    ContactAnimationViewController *contactAnimationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactAnimationVC"];
    contactAnimationVC.transitioningDelegate = self;
    contactAnimationVC.selectedStationName = self.selectedStationName;
    contactAnimationVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:contactAnimationVC animated:YES completion:nil];
}


-(void) shadowBtn:(UIButton*)btnName
{
    btnName.layer.cornerRadius = 0.1f;
    btnName.layer.borderColor = [UIColor whiteColor].CGColor;
    [btnName setBackgroundColor:[UIColor whiteColor]];
    btnName.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    btnName.layer.shadowRadius = 1.0;
    btnName.layer.shadowOffset = CGSizeMake(0.3, 0.3);
    btnName.layer.shadowOpacity = 1.0;
}

-(IBAction)backAction:(id)sender
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
