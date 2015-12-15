/////////////////////////////////////////////////////////////////////
//  ControllerName:  XMLParser.m                                   ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////


#import <Foundation/Foundation.h>
#import "XMLParser.h"

@implementation XMLParser
@synthesize Recipes = _Recipes;


NSMutableString	*currentNodeContent;//Store each value read from XML file
NSXMLParser		*parser;//Object for parsing the XML file
Recipe			*currentRecipe;
bool            isStatus;

//Reads the XML URL and Stores it in an Object
-(id) loadXMLByURL:(NSString *)urlString
{
    _Recipes		= [[NSMutableArray alloc] init];
    NSURL *url		= [NSURL URLWithString:urlString];
    NSData	*data   = [[NSData alloc] initWithContentsOfURL:url];
    parser			= [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//Checks the particular tag is present in the XML file
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementname isEqualToString:@"recipe"])
    {
        currentRecipe = [Recipe alloc];
        isStatus = YES;
    }
    
}

//Stores the value of the tags if the child tags matches
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (isStatus)
    {
        if ([elementname isEqualToString:@"title"])
        {
            currentRecipe.content = currentNodeContent;
        }
        if ([elementname isEqualToString:@"preparation"])
        {
            currentRecipe.details = currentNodeContent;
        }
        if ([elementname isEqualToString:@"img"])
        {
            currentRecipe.image = currentNodeContent;
        }
        if ([elementname isEqualToString:@"preptime"])
        {
            currentRecipe.preptime = currentNodeContent;
        }
        if ([elementname isEqualToString:@"ingredients"])
        {
            currentRecipe.ingredients = currentNodeContent;
        }
        
    }
    if ([elementname isEqualToString:@"recipe"])
    {
        [self.Recipes addObject:currentRecipe];
        currentRecipe = nil;
        currentNodeContent = nil;
    }
}

@end

