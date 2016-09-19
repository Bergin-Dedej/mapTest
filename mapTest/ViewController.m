//
//  ViewController.m
//  mapTest
//
//  Created by Ber Jr on 2016-09-13.
//  Copyright © 2016 Ber Jr. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>


@interface ViewController ()
@end

@implementation ViewController {
    CLLocationManager *locationManager;
    GMSCameraPosition *camera;
    GMSMapView *mapView;
    double startLatitude;
    double startLongitude;
    CLLocationCoordinate2D startLocation;
}


- (void)loadView {


    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    
    startLatitude = locationManager.location.coordinate.latitude;
    startLongitude = locationManager.location.coordinate.longitude;
    startLocation = locationManager.location.coordinate;
    
    camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:17];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    CLLocationCoordinate2D circleCenter = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude);
    GMSCircle *circ = [GMSCircle circleWithPosition:circleCenter radius:150];
    circ.map = mapView;
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(locationManager.location.coordinate.latitude,locationManager.location.coordinate.latitude);
    marker.title = @"100 Points";
    marker.snippet = @"Star";
    marker.map = mapView;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {

    MKMapPoint p1 = MKMapPointForCoordinate(startLocation);
    MKMapPoint p2 = MKMapPointForCoordinate(locationManager.location.coordinate);
    CLLocationDistance distanceRun = MKMetersBetweenMapPoints(p1, p2);
    
    if(distanceRun >= 150){
        NSString *congrats = @"Congrats you ran past 150 meters!";
        NSLog(congrats);
    }
    NSString *myString = [NSString stringWithFormat:@"%f", distanceRun];
    NSLog(myString);
    
    camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:17];
    [mapView animateToCameraPosition:camera];

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
