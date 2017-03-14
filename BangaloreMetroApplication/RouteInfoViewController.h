//
//  RouteInfoViewController.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteInfoViewController : UIViewController
@property (nonatomic, strong) NSString *fromStr;
@property (nonatomic, strong) NSString *toStr;
@property (nonatomic, strong)  NSString *distanceTextStr;
@property (nonatomic, strong)  NSString *timeTextStr;
@property (nonatomic, strong)  NSString *fareTextStr;
@property (nonatomic, strong)  NSString *stationsInBetweenTextStr;


@property (nonatomic, strong) IBOutlet UILabel *fromTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *toTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *distanceTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *fareTextLabel;
@property (nonatomic, strong) IBOutlet UITextView *stationsInBetweenTextLabel;



@end
