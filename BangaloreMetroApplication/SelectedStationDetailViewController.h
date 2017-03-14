//
//  SelectedStationDetailViewController.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SelectedStationDetailViewController : UIViewController<UIViewControllerTransitioningDelegate>

@property(strong, nonatomic) NSString *selectedStationName;
@property(strong, nonatomic) IBOutlet UIButton *backBtn;

@end
