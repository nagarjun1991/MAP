/////////////////////////////////////////////////////////////////////
//  ControllerName:  DetailView.m                                  ||
//  ProjectName:     TasteOfHome                                   ||
//  Author:          Nagarjun Nama Balaji and Pavana Venkataswamy  ||
//  Copyright © 2015 Nagarjun Nama Balaji. All rights reserved.    ||
/////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import "DetailView.h"

@implementation DetailView

@synthesize name;
@synthesize image;
@synthesize description;
@synthesize ingredients;
@synthesize preparation;

XMLParser *xmlParser1;//Object to store the xml data

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"xml" inDirectory:@"XML"];// stores the path of xml file
    NSString *fp=@"file:///";
    fp = [fp stringByAppendingString:filePath];
    xmlParser1 = [[XMLParser alloc] loadXMLByURL:fp];
    for(int i =0 ; i<[xmlParser1 Recipes].count;i++)//loop to parse the xml file
    {
         Recipe * currentRecipe = [[xmlParser1 Recipes]objectAtIndex:i];
        NSString *ActualData = self.item; // store the name of the selected recipe
        if([currentRecipe.content isEqualToString:ActualData]) // checks whether the current recipe matches the selected recipe
          {
              self.name=currentRecipe.content;
              self.preptime.text= currentRecipe.preptime;
              self.image.image = [UIImage imageNamed:currentRecipe.image];
              NSString *myString = currentRecipe.ingredients;
              NSArray *myWords = [myString componentsSeparatedByString:@","];
              NSMutableString *ingredientText = [NSMutableString string];
              for (NSString* ingredient in myWords)
               {
                  [ingredientText appendFormat:@"%@\n", ingredient];
               }
              self.ingredients.text = ingredientText;
              
              NSString *String = currentRecipe.details;
              NSArray *Words = [String componentsSeparatedByString:@","];
              NSMutableString *preparationtext = [NSMutableString string];
              for (NSString* prepare in Words)
              {
                  [preparationtext appendFormat:@"%@\n", prepare];
              }
              
              self.preparation.text = preparationtext;
         self.title= currentRecipe.content;
              
          }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)Mail:(id)sender // action to mail the recipe
{
    MFMailComposeViewController *MailController = [[MFMailComposeViewController alloc]init];
    [MailController setMailComposeDelegate:self];
    NSString *emailTitle = [self name];
    NSMutableString *body = [NSMutableString string];
    NSString *message = [[self ingredients]text];
    NSString *message1 = [[self preparation]text];
    [body appendString:@"Ingredients: \n"];
    [body appendString:message];
    [body appendString:@"Preparation:\n"];
    [body appendString:message1];
    [MailController setSubject:emailTitle];
    [MailController setMessageBody:body isHTML:NO]; //contains the ingredients and description as part of the email body
   NSLog(@"body:%@",body);
    [self presentViewController:MailController animated:YES completion:NULL];
    
}

//Check for the possible outcomes of the email
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
            
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
