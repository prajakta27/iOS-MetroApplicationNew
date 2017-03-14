//
//  SearchRouteViewController.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchRouteViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>
@property (strong, nonatomic) NSString *selectedStationString;
@property (strong, nonatomic) IBOutlet UITableView *toTableView;
@property (strong, nonatomic) NSString *searchedStationString;
@property (weak, nonatomic) IBOutlet UITableView *fromTableView;
@property (strong, nonatomic) IBOutlet UITextField *fromTextFieldView;
@property (strong, nonatomic) IBOutlet UITextField *toTextFieldView;
@property (strong, nonatomic) UITableView *searchedStationsTable;
@property(strong,nonatomic) NSString* dataBasePath;
@property(strong, nonatomic) NSMutableArray *searchedResultArray;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIView *middlView;
@property(strong, nonatomic) NSArray *detailsArry;



@end
