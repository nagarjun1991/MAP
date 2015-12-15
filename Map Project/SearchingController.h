/////////////////////////////////////////////////////////////////////
//  ControllerName:  SearchingController.h                         ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XMLParser.h"
#import "Recipe.h"


@interface SearchingController : UITableViewController <UITableViewDataSource ,UITableViewDelegate,UISearchControllerDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *recipe;//Tableview to display the list of recipes
@property (assign) BOOL locationUseBool;


@end