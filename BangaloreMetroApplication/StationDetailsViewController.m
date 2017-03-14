//
//  StationDetailsViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "StationDetailsViewController.h"
#import "SelectedStationDetailViewController.h"

@interface StationDetailsViewController ()
{
    NSArray *tableData;
    NSString *selectedStationName;
}

@end

@implementation StationDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stationNameTable.delegate = self;
    self.stationNameTable.dataSource = self;
    tableData = [[NSArray alloc]init];
    tableData = [NSArray arrayWithObjects:@"Baiyyappanahalli",@"Swami Vivekananda Road", @"Indiranagar",@"Mahatma Gandhi Road", @"Halasuru", @"Trinity", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedStationName = [tableData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"selectedstationseguesegue" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"selectedstationseguesegue"]) {
        
        SelectedStationDetailViewController *selectedStationVC = (SelectedStationDetailViewController*)[segue destinationViewController];
        selectedStationVC.selectedStationName = selectedStationName;
        
    }
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
