//
//  NearestStationViewController.h
//  BangaloreMetroApplication
//
//  Created by Prajakta Vishwas Sonawane on 3/7/17.
//  Copyright © 2017 Prajakta Vishwas Sonawane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>


@interface NearestStationViewController : UIViewController<CLLocationManagerDelegate,CLLocationManagerDelegate,GMSMapViewDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *nameLabel;
@property (nonatomic, strong) NSString *addressLabel;
@property (assign, nonatomic) float addressLatitude;
@property (assign, nonatomic) float addressLongitude;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, assign) BOOL isFromDetailView;
@property(strong, nonatomic) NSString *selectedStationName;
@property (assign, nonatomic) float selectedStationLatitude;
@property (assign, nonatomic) float selectedStationLongitude;
@end
