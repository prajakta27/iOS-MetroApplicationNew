//
//  SearchRouteViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "SearchRouteViewController.h"
#import "RouteInfoViewController.h"
#import <UIKit/UIKit.h>
#import "APIFile.h"
#import "APIPackets.h"
#import "DataObjectFile.h"


@interface SearchRouteViewController ()
{
    NSString *toStr;
    NSString *fromStr;
    UIActivityIndicatorView *spinner;
    NSMutableArray *autoCompleteListArr;
    UIAlertView *alert;
    
}
@property (assign, nonatomic) BOOL toTextFieldSeletcedBool;
@end

@implementation SearchRouteViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self searchTableView];
    self.searchedStationsTable = [[UITableView alloc]init];
    self.searchedStationsTable.delegate = self;
    self.searchedStationsTable.dataSource = self;
  
    self.fromTextFieldView.delegate = self;
    self.toTextFieldView.delegate = self;
    

//    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    [spinner setColor:[UIColor purpleColor]];
//    spinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
//    [self.view addSubview:spinner];
//    [spinner startAnimating];
    
    alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Loading...." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(139.5, 75.5);
    [alert setValue:spinner forKey:@"accessoryView"];
    [spinner startAnimating];
    
    //[alert show];
}

-(void)stopLoadingAlert
{
    if(alert != nil)
        [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *fromOrToString = [NSString stringWithString:textField.text];
    fromOrToString = [fromOrToString stringByReplacingCharactersInRange:range withString:string];
    if ([self.fromTextFieldView isFirstResponder] == YES)
    self.toTextFieldSeletcedBool = NO;
    else if([self.toTextFieldView isFirstResponder] == YES)
    self.toTextFieldSeletcedBool =YES;
    
    fromOrToString = [fromOrToString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
    
    
    
    
    if (range.length == 1 && string.length == 0)
        [self.searchedStationsTable setHidden:YES];
    
    
    if([fromOrToString length] <= 1)
    {
         [self.searchedStationsTable setHidden:YES];
    }
    else if ([fromOrToString length] == 2)
    {
        [self searchTableView];
        [self findSearchedCityAPICall:fromOrToString];
    }
    return YES;
}

//table view
-(void)searchTableView
{
   
    if (self.toTextFieldSeletcedBool == NO)
    [self.searchedStationsTable setFrame:CGRectMake(self.fromTextFieldView.frame.origin.x, self.fromTextFieldView.frame.size.height+self.fromTextFieldView.frame.origin.y, self.fromTextFieldView.frame.size.width, 35)];
    else
    [self.searchedStationsTable setFrame:CGRectMake(self.toTextFieldView.frame.origin.x, self.toTextFieldView.frame.size.height+self.toTextFieldView.frame.origin.y, self.toTextFieldView.frame.size.width, 35)];
    
    [self.middlView addSubview:self.searchedStationsTable];

}

-(void)findSearchedCityAPICall:(NSString *)searchString
{
    self.searchedStationString = searchString;
    Request *pRequest = nil;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.searchedStationString forKey:@"stationName"];
    [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodGet AndDictionry:dic AndRequestIDIdentifier:GET_SEARCHED_DATA_GET_REQUEST_ID];
    
    RequestStatus *reqSt=pRequest.requestStatus;
    [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
    
    NSLog(@"Calling reloadData on %@", self.searchedStationsTable);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [[DataObjectFile getInstance] searchStationResultArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
   if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    self.selectedStationString = [NSString stringWithFormat:@"%@", [autoCompleteListArr objectAtIndex:indexPath.row]];
    cell.textLabel.text = self.selectedStationString;
    [self.searchedStationsTable setUserInteractionEnabled:YES];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13]];
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.toTextFieldSeletcedBool == NO)
    {
        self.fromTextFieldView.text = self.selectedStationString;
        fromStr = self.selectedStationString;
        [[self view] endEditing:YES];
    }
    else
    {
        self.toTextFieldView.text = self.selectedStationString;
        toStr = self.selectedStationString;
        [[self view] endEditing:YES];
    }
    [self.searchedStationsTable setHidden:YES];
}


-(IBAction)searchBttnCalled:(id)sender
{
    if (![self.fromTextFieldView.text isEqualToString:@""] && ![self.toTextFieldView.text isEqualToString:@""]) {
         [self callInfoApi];
    }
}

-(void) callInfoApi
{
    
    Request *pRequest = nil;
    [alert show];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:fromStr forKey:@"fromStationName"];
    [dic setValue:toStr forKey:@"toStationName"];
    
    [APIFile callServerAPIWithRequest:&pRequest httpMethodType:hTTPMethodGet AndDictionry:dic AndRequestIDIdentifier:GET_SEARCHED_DATA_INFO_REQUEST_ID];
    
    RequestStatus *reqSt=pRequest.requestStatus;
    [reqSt addObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void*)pRequest];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"routeinfosegue"]) {
        
        [self stopLoadingAlert];
        RouteInfoViewController *dest = (RouteInfoViewController*)[segue destinationViewController];
        dest.fromStr = fromStr;
        dest.toStr = toStr;
        NSDictionary *patientObj = [self.detailsArry objectAtIndex:0];
        NSString *str = [NSString stringWithFormat:@"%@", [patientObj valueForKey:@"distance"]];
        dest.distanceTextStr  = str;
        dest.fareTextStr = [patientObj valueForKey:@"fare"];
        dest.stationsInBetweenTextStr = [patientObj valueForKey:@"station_in_between"];
        dest.timeTextStr =  [patientObj valueForKey:@"time"];
        
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.fromTextFieldView resignFirstResponder];
    [self.toTextFieldView resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    Request *pRequest = ((__bridge Request*)context);
    if(pRequest.requestID == GET_SEARCHED_DATA_GET_REQUEST_ID)
    {
        if([[DataObjectFile getInstance]searchStationResultArray] != nil)
        {
            [autoCompleteListArr removeAllObjects];
            if([[[DataObjectFile getInstance] searchStationResultArray] count])
            {
                [self.searchedStationsTable setHidden:NO];
                //------------newww------------------------
                autoCompleteListArr=[[NSMutableArray alloc] initWithArray:[[DataObjectFile getInstance] searchStationResultArray]];
                [self performSelectorOnMainThread:@selector(updateTable) withObject:nil waitUntilDone:NO];
            }
        }
    }
    else if(pRequest.requestID == GET_SEARCHED_DATA_INFO_REQUEST_ID)
    {
        if([[DataObjectFile getInstance]searchStationInfoResultArray] != nil)
        {
            self.detailsArry = [[DataObjectFile getInstance] searchStationInfoResultArray];
            ;
            [spinner stopAnimating];
            [self performSegueWithIdentifier:@"routeinfosegue" sender:self];
        }
    }
    [pRequest.requestStatus removeObserver:self forKeyPath:KEY_PATH_REQUEST_STATUS];
}

-(void)updateTable
{
    [self.searchedStationsTable reloadData];
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
