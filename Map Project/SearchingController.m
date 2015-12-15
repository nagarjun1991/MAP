/////////////////////////////////////////////////////////////////////
//  ControllerName:  SearchingController.m                         ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "SearchingController.h"
#import "XMLParser.h"
#import "DetailView.h"
#import <UIKit/UIKit.h>

@implementation SearchingController
@synthesize recipe=_recipe;
@synthesize locationUseBool=_locationUseBool;


XMLParser *xmlParser;//XML parser object
NSMutableArray *curr;//Array to store recipe titles
NSMutableArray *curr1;// Array to store recipe images

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"xml" inDirectory:@"XML"];
    NSString *fp=@"file:///";
    fp = [fp stringByAppendingString:filePath];
    xmlParser = [[XMLParser alloc] loadXMLByURL:fp];
    [self.recipe setDelegate:self];
    [self.recipe setDataSource:self];
    self.title = @"Recipes";
    [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//Returns the count of recipes
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [curr count];

    }
    else
    {
        return [[xmlParser Recipes] count];
    }
    
}

//Displays the values to the table cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    Recipe *currentRecipe = [[xmlParser Recipes] objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    }
    
    
    cell.textLabel.textColor = [UIColor blueColor];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [curr objectAtIndex:indexPath.row];
        NSString *imagename = [curr1 objectAtIndex:indexPath.row ];
        cell.imageView.image = [UIImage imageNamed:imagename];
        _locationUseBool =YES;
    }
    else
    {
        cell.textLabel.text = [currentRecipe content];
        cell.imageView.image = [UIImage imageNamed:currentRecipe.image];
       
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

//Passes the value of selected row to the Detail View
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger number;
    DetailView *destViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailView"];
    if (_locationUseBool)
    {
        indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        destViewController.item = [curr objectAtIndex:indexPath.row];
    }
    else
    {
        indexPath = [self.recipe indexPathForSelectedRow];
        number =indexPath.row;
        Recipe *rec = [[xmlParser Recipes] objectAtIndex:number];
        NSString * re = rec.content;
        destViewController.item = re;
    }
    
    [self.navigationController pushViewController: destViewController animated:YES];
}

//Filters the table view content based on search text
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
      curr = [[NSMutableArray alloc] init];
      curr1 = [[NSMutableArray alloc] init];
    for(int i =0 ; i< ([xmlParser Recipes].count); i++)
    {
        Recipe *current = [[xmlParser Recipes] objectAtIndex:i];
        NSString * abc = current.content;
        NSString *im = current.image;
        NSRange list = [abc rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if(list.location != NSNotFound)
        {
         [curr addObject:abc];
         [curr1 addObject:im];
        }
    }

    [self.tableView reloadData ];
}



//Provides a list of filtered recipes and reloads table
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    [self.tableView reloadData];

    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end

