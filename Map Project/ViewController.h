/////////////////////////////////////////////////////////////////////
//  ControllerName:  ViewController.h                              ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : UIViewController<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *send; //Button to direct from HomeView to SearchView

@end

