/////////////////////////////////////////////////////////////////////
//  ControllerName:  StoreLocatorController.m                      ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "StoreLocatorController.h"
#import "AppDelegate.h"
@import CoreLocation;


@implementation StoreLocatorController:UIViewController



@synthesize mapview = _mapview;
@synthesize location= _location;

#pragma mark - View lifecycle
-(void)viewDidLoad
{
    
    [super viewDidLoad];
    [self.mapview setDelegate:self];
    [self.location setDelegate:self];
     self.mapview.showsUserLocation = YES;
    [self.mapview setMapType:MKMapTypeStandard];
    [self.mapview setZoomEnabled:YES];
    [self.mapview setScrollEnabled:YES];
    [self.mapview setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//When userlocation is updated it shows on the mapView
-(void) mapView:(MKMapView * ) mapView didUpdateUserLocation:(MKUserLocation *) userlocation
     {
         
         [self createAnnotations];
         [self.mapview setRegion:MKCoordinateRegionMake(userlocation.coordinate, MKCoordinateSpanMake(0.10f, 0.10f)) animated:NO];
         [self.mapview showAnnotations:self.mapview.annotations animated:YES];
     }


//To add the placemarkers for places around the user's current location
-(void)createAnnotations
{
    
    self.annotations=[[NSMutableArray alloc] init];
    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];//Query to connect to Parse Database to get the latitue and longitude of the stores
    [query whereKey:@"Latitude" lessThan:@(46)];
    [query whereKey:@"Latitude" greaterThan:@(42)];
    [query whereKey:@"Longitude" lessThan:@(-76)];
    [query whereKey:@"Longitude" greaterThan:@(-80)];
    NSArray* scoreArray = [query findObjects];//stores details if all the above conditions have matched
    for (NSDictionary *row in scoreArray)
    {
        NSNumber *latitude = [row objectForKey:@"Latitude"];//Stores the latitude value
        NSNumber *longitude = [row objectForKey:@"Longitude"];//Stores the longitude value
        NSString *str = [row objectForKey:@"StoreName"];//Stores the store name
        MKPointAnnotation *mark= [[MKPointAnnotation alloc] init];//Adds place mark to the corresponding latitude and longitude
        mark.coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
        mark.title =str;
        [self.mapview addAnnotation:mark];
    }
}
@end