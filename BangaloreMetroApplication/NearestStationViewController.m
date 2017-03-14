//
//  NearestStationViewController.m
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import "NearestStationViewController.h"

#import <GooglePlaces/GooglePlaces.h>
#import <GooglePlacePicker/GooglePlacePicker.h>
#import <GoogleMaps/GoogleMaps.h>

@import GoogleMaps;
@interface NearestStationViewController ()
{
    GMSPlacesClient *placesClient;
}

@end

@implementation NearestStationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    placesClient = [GMSPlacesClient sharedClient];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t
{
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
    NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=false&avoid=highways&mode=driving",saddr,daddr]];
    
    NSError *error = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: &error];
    
    if (response == nil) {
        // Check for problems
        if (error != nil) {
            NSLog(@"error --->>>%@",error);
        }
    }
    else {
        // Data was received.. continue processing
    }
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
  
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONWritingPrettyPrinted error:nil];
    
    return [self decodePolyLine:[self parseResponse:dic]];
}

- (NSString *)parseResponse:(NSDictionary *)response {
   
    NSArray *routes = [response objectForKey:@"routes"];
    NSDictionary *route = [routes lastObject];
    if (route) {
        NSString *overviewPolyline = [[route objectForKey:
                                       @"overview_polyline"] objectForKey:@"points"];
        return overviewPolyline;
    }
    return @"";
}

-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr
{
    NSMutableString *encoded = [[NSMutableString alloc]
                                initWithCapacity:[encodedStr length]];
    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0,
                                                    [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1)
                          : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1)
                          : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:
                                [latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    return array;
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[[locations count] -1];
    CLLocation *currentLocation = newLocation;
    float longitude = currentLocation.coordinate.longitude;
    float latitude = currentLocation.coordinate.latitude;
    
    if (currentLocation != nil)
    {
        NSString* formattedLattitudeNumber = [NSString stringWithFormat:@"%.5f", latitude];
        self.addressLatitude = atof([formattedLattitudeNumber UTF8String]);
        
        NSString* formattedLongitudeNumber = [NSString stringWithFormat:@"%.5f", longitude];
        self.addressLongitude = atof([formattedLongitudeNumber UTF8String]);
        
        [[GMSGeocoder geocoder] reverseGeocodeCoordinate:(CLLocationCoordinate2D){.latitude = self.addressLatitude, .longitude = self.addressLongitude} completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error)
         {
             [self loadMapViewWithDirection];
         }];
        [self.locationManager stopUpdatingLocation];
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }
}
- (void)loadMapViewWithDirection
{
    
    [_mapView clear];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.addressLatitude longitude:self.addressLongitude zoom:12];
    self.mapView.camera = camera;
    self.mapView.settings.scrollGestures = YES;
    self.mapView.settings.zoomGestures = YES;
    self.mapView.myLocationEnabled = YES;
    
    
    GMSMarker *sourceMarker = [[GMSMarker alloc] init];
    sourceMarker.position = CLLocationCoordinate2DMake(self.addressLatitude, self.addressLongitude);
    sourceMarker.map = self.mapView;
    
    
    if (self.isFromDetailView == YES) {
        
        
        GMSMarker *destMarker1 = [[GMSMarker alloc] init];
        destMarker1.position = CLLocationCoordinate2DMake(self.selectedStationLatitude, self.selectedStationLongitude);
        destMarker1.map = self.mapView;
        destMarker1.title = self.selectedStationName;
        
        [self drawDirection:CLLocationCoordinate2DMake(self.addressLatitude, self.addressLongitude) and:CLLocationCoordinate2DMake(self.selectedStationLatitude,self.selectedStationLongitude)];
    }
    else
    {
    
        GMSMarker *destMarker1 = [[GMSMarker alloc] init];
        destMarker1.position = CLLocationCoordinate2DMake(12.9907, 77.6525);
        destMarker1.map = self.mapView;
        destMarker1.title = @"Baiyappanahalli Metro Station";
        
        GMSMarker *destMarker2 = [[GMSMarker alloc] init];
        destMarker2.position = CLLocationCoordinate2DMake(12.9859, 77.6449);
        destMarker2.map = self.mapView;
        destMarker2.title = @"Swami Vivekananda Road Metro Station";
        
        
        GMSMarker *destMarker3 = [[GMSMarker alloc] init];
        destMarker3.position = CLLocationCoordinate2DMake(12.9783, 77.6388);
        destMarker3.map = self.mapView;
        destMarker3.title = @"Indiranagar Metro Station";
        
        GMSMarker *destMarker4 = [[GMSMarker alloc] init];
        destMarker4.position = CLLocationCoordinate2DMake(12.9764, 77.6267);
        destMarker4.map = self.mapView;
        destMarker4.title = @"Halsuru Metro Station";
        
        GMSMarker *destMarker5 = [[GMSMarker alloc] init];
        destMarker5.position = CLLocationCoordinate2DMake(12.9729, 77.6170);
        destMarker5.map = self.mapView;
        destMarker5.title = @"Trinity Metro Station";
        
        GMSMarker *destMarker6 = [[GMSMarker alloc] init];
        destMarker6.position = CLLocationCoordinate2DMake(12.9756, 77.6066);
        destMarker6.map = self.mapView;
        destMarker6.title = @"M.G. Road Metro Station";
    }
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    // your code

    
    [self drawDirection:CLLocationCoordinate2DMake(self.addressLatitude, self.addressLongitude) and:CLLocationCoordinate2DMake(marker.position.latitude, marker.position.longitude)];
    return YES;
}

- (void) drawDirection:(CLLocationCoordinate2D)source and:(CLLocationCoordinate2D) dest
{
    
    GMSPolyline *polyline = [[GMSPolyline alloc] init];
    GMSMutablePath *path = [GMSMutablePath path];
    
    NSArray * points = [self calculateRoutesFrom:source to:dest];
    
    NSInteger numberOfSteps = points.count;
    for (NSInteger index = 0; index < numberOfSteps; index++)
    {
        CLLocation *location = [points objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        [path addCoordinate:coordinate];
    }
    
    polyline.path = path;
    polyline.strokeColor = [UIColor redColor];
    polyline.strokeWidth = 4.f;
    polyline.map = self.mapView;
    
    // Copy the previous polyline, change its color, and mark it as geodesic.
    polyline = [polyline copy];
    polyline.strokeColor = [UIColor blueColor];
    polyline.geodesic = YES;
    polyline.map = self.mapView;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

