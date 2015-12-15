/////////////////////////////////////////////////////////////////////
//  ControllerName: XMLParser.h                                    ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>

#import "Recipe.h"

@interface XMLParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *Recipes;//Array to store recipes read from the XML file

-(id) loadXMLByURL:(NSString *)urlString;//Stores Recipe URL

@end
