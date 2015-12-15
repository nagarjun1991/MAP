/////////////////////////////////////////////////////////////////////
//  ControllerName:  Recipe.h                                      ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>

@interface Recipe : NSObject

@property (strong, nonatomic)NSString *content;//Stores the Name of Recipe
@property (strong, nonatomic)NSString *image;//Stores the Image of Recipe
@property (strong, nonatomic)NSString *preptime;//Stores the Preparation Time of the Recipe
@property (strong, nonatomic)NSString *details;//Stores the Description of the Recipe
@property (strong, nonatomic)NSString *ingredients;//Stores the Ingredients List of the Recipe

@end;