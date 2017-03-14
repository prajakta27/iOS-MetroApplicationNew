//
//  AboutUsViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toolFreeCallClickedAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://+91180042512345"]]];
    
}

-(IBAction)callClicked1Action:(id)sender
{
    NSString *phNo = @"+91 80 2296 9300";
    phNo = [phNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@,",phNo]]];
}

-(IBAction)callClicked2Action:(id)sender
{
    NSString *phNo2 = @"+91 80 2296 9301";
    phNo2 = [phNo2 stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phNo2]]];
}

-(IBAction)openMailButtonClickAction:(id)sender
{
    
    NSString *recipients = @"bmrcl@dataone.in";
    NSString *email = [NSString stringWithFormat:@"%@", recipients];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(IBAction)openSiteButtonClickAction:(id)sender
{
    NSString* text = @"www.bmrc.co.in";
    NSURL*    url  = [[NSURL alloc] initWithString:text];
    
    if (url.scheme.length == 0)
    {
        text = [@"http://" stringByAppendingString:text];
        url  = [[NSURL alloc] initWithString:text];
    }
    [[UIApplication sharedApplication] openURL:url];
}

-(IBAction)backActn:(id)sender
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
