/////////////////////////////////////////////////////////////////////
//  ControllerName:  DetailView.h                                  ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "XMLParser.h"
#import "Recipe.h"
@import MessageUI;


@interface DetailView:UIViewController<MFMailComposeViewControllerDelegate>

@property NSString *item;//Used to pass data from one controller to the other controller
@property (weak, nonatomic) IBOutlet UITextView *preparation;//Displays the description to prepare the Recipe
@property (weak, nonatomic) IBOutlet UIImageView *image;//Display the Recipe Image
@property NSString  *name;// Display the Recipe Name
@property (weak, nonatomic) IBOutlet UILabel *preptime;//Display the Preparation Time for the Recipe
@property (weak, nonatomic) IBOutlet UITextView *ingredients;//Display the list of Ingredients
@property(nonatomic,strong) Recipe *recipe;// Object of Recipe

@end