//
//  ContactAnimationViewController.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactAnimationViewController : UIViewController

@property(strong, nonatomic) NSString *selectedStationName;
@property (weak, nonatomic) IBOutlet UIButton *contactNumberBtn;
@property (weak, nonatomic) IBOutlet UITextView *addressLbl;
@property(strong, nonatomic) NSMutableDictionary *stationDetailsDic;
@property (weak, nonatomic) IBOutlet UIButton *navigateLocButton;

@property (assign, nonatomic) float stationLattitude;
@property (assign, nonatomic) float stationLongitude;


@end
