//
//  ContactAnimationViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "ContactAnimationViewController.h"
#import "NearestStationViewController.h"
#import "DataObjectFile.h"

@interface ContactAnimationViewController ()

@end

@implementation ContactAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stationDetailsDic = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *indiranagerDic = [[NSMutableDictionary alloc] init];
    [indiranagerDic setObject:@"098454 26312" forKey:@"PhoneNo"];
    [indiranagerDic setObject:@"Chinmaya Mission Hospital Rd, Binnamangala, Stage 1, Indiranagar, Bengaluru, Karnataka 560038" forKey:@"Address"];
    [indiranagerDic setObject:@"12.9783" forKey:@"Lat"];
    [indiranagerDic setObject:@"77.6388" forKey:@"Long"];
    
    
    NSMutableDictionary *baipanahalliDic = [[NSMutableDictionary alloc] init];
    [baipanahalliDic setObject:@"No phone number provided" forKey:@"PhoneNo"];
    [baipanahalliDic setObject:@"Sadanandanagar, Bennigana Halli, Bengaluru, Karnataka 560033" forKey:@"Address"];
    [baipanahalliDic setObject:@"12.9907" forKey:@"Lat"];
    [baipanahalliDic setObject:@"77.6525" forKey:@"Long"];
    
    
    NSMutableDictionary *halsuruDic = [[NSMutableDictionary alloc] init];
    [halsuruDic setObject:@"No phone number provided" forKey:@"PhoneNo"];
    [halsuruDic setObject:@"Old Madras Road, Gupta Layout, Halasuru, Bengaluru, Karnataka 56000" forKey:@"Address"];
    [halsuruDic setObject:@"12.9764" forKey:@"Lat"];
    [halsuruDic setObject:@"77.6267" forKey:@"Long"];
    
    
    NSMutableDictionary *trinityDic = [[NSMutableDictionary alloc] init];
    [trinityDic setObject:@"No phone number provided" forKey:@"PhoneNo"];
    [trinityDic setObject:@"MG Road, Yellappa Chetty Layout, Sivanchetti Gardens, Bengaluru, Karnataka 560001" forKey:@"Address"];
    [trinityDic setObject:@"12.9729" forKey:@"Lat"];
    [trinityDic setObject:@"77.6170" forKey:@"Long"];
    
    
    NSMutableDictionary *MGRoadDic = [[NSMutableDictionary alloc] init];
    [MGRoadDic setObject:@"088676 64201" forKey:@"PhoneNo"];
    [MGRoadDic setObject:@"MG Road, Shivaji Nagar, Bengaluru, Karnataka 560001" forKey:@"Address"];
    [MGRoadDic setObject:@"12.9756" forKey:@"Lat"];
    [MGRoadDic setObject:@"77.6066" forKey:@"Long"];
    
    
    NSMutableDictionary *swamiVivekanandaDic = [[NSMutableDictionary alloc] init];
    [swamiVivekanandaDic setObject:@"No phone number provided" forKey:@"PhoneNo"];
    [swamiVivekanandaDic setObject:@" Swamy Vivekananda Rd, New Baiyyappanahalli Extension, Sarvagnanagar, Bengaluru, Karnataka 560038" forKey:@"Address"];
    [swamiVivekanandaDic setObject:@"12.9859" forKey:@"Lat"];
    [swamiVivekanandaDic setObject:@"77.6449" forKey:@"Long"];
    
    
    [self.stationDetailsDic setObject:baipanahalliDic forKey:@"Baiyyappanahalli"];
    [self.stationDetailsDic setObject:swamiVivekanandaDic forKey:@"Swami Vivekananda Road"];
    [self.stationDetailsDic setObject:indiranagerDic forKey:@"Indiranagar"];
    [self.stationDetailsDic setObject:halsuruDic forKey:@"Halasuru"];
    [self.stationDetailsDic setObject:trinityDic forKey:@"Trinity"];
    [self.stationDetailsDic setObject:MGRoadDic forKey:@"Mahatma Gandhi Road"];
    
    
    NSLog(@"%@",[self.stationDetailsDic valueForKey:self.selectedStationName]);
    
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [DataObjectFile getInstance].isFromDetailView = NO;
    self.contactNumberBtn.titleLabel.text = [NSString stringWithFormat:@"%@",[[self.stationDetailsDic valueForKey:self.selectedStationName] valueForKey:@"PhoneNo"]];
    self.stationLattitude = [[[self.stationDetailsDic valueForKey:self.selectedStationName] valueForKey:@"Lat"]floatValue];
    self.stationLongitude = [[[self.stationDetailsDic valueForKey:self.selectedStationName] valueForKey:@"Long"]floatValue];
    self.addressLbl.text = [[self.stationDetailsDic valueForKey:self.selectedStationName] valueForKey:@"Address"];
    [self.contactNumberBtn setTitle:[[self.stationDetailsDic valueForKey:self.selectedStationName] valueForKey:@"PhoneNo"] forState:UIControlStateNormal];
   
}
-(IBAction)closeAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)toolFreeClickAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+91180042512345"]]];
    
}
-(IBAction)phoneClickNo:(id)sender
{
    
}

-(IBAction)locationClickAction:(id)sender
{
    

    [self performSegueWithIdentifier:@"nearestlocationsegue" sender:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"nearestlocationsegue"]) {
        
        NearestStationViewController *nearestStaionVC = (NearestStationViewController*)[segue destinationViewController];
        [DataObjectFile getInstance].isFromDetailView = YES;
        nearestStaionVC.isFromDetailView = YES;
        nearestStaionVC.selectedStationName = self.selectedStationName;
        nearestStaionVC.selectedStationLatitude = self.stationLattitude;
        nearestStaionVC.selectedStationLongitude = self.stationLongitude;
    }
}

@end
