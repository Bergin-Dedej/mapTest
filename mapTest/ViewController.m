//
//  ViewController.m
//  mapTest
//
//  Created by Ber Jr on 2016-09-13.
//  Copyright © 2016 Ber Jr. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>


@interface ViewController ()
@end

@implementation ViewController {
    CLLocationManager *locationManager;
    GMSCameraPosition *camera;
    GMSMapView *mapView;
}


- (void)loadView {


    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    
    camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:17];

    mapView.myLocationEnabled = YES;
    self.view = mapView;
    NSLog(@"My Location: %@", mapView.myLocation);
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView;
 

}

- (void)viewDidLoad {
    [super viewDidLoad];
     
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
