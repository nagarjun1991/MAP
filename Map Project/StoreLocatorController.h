/////////////////////////////////////////////////////////////////////
//  ControllerName:  StoreLocatorController.h                      ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>


@interface StoreLocatorController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *mapview;//Object of MapView
}

@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong,nonatomic) CLLocationManager *location;//Object for CLLocationManager
@property(strong,nonatomic) NSMutableArray *annotations;//Stores the places around the user's current location


-(void)createAnnotations;
@end
