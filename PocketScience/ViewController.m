//
//  ViewController.m
//  PocketScience
//
//  Created by pramesh on 4/17/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import "ViewController.h"
#import "Data.h"
#import "AsyncImageView.h"

@interface ViewController ()
{
    NSArray *casts;
    NSArray *searchResults;
    NSString *mailMessage;
    NSDictionary *myDict;
    NSString *cellValue;
}
@end

@implementation ViewController

@synthesize jsonSearchBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *restUrl = [NSURL URLWithString:@"http://www.nousguideinc.com/12323123dsfsdf/4358h.json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:restUrl options:NSDataReadingUncached error:&error];
    if(!error)
    {
        // create NSDictionary from the JSON data
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        // Create a new array to hold Cast
        casts = [jsonDictionary objectForKey:@"cast"];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.titleText contains[cd] %@ OR SELF.detailText contains[cd] %@", searchText, searchText];
    searchResults = [casts filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail Saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail Sent");
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// UITableViewDelegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResults count];
    }
    else
    {
        return [casts count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    myDict = [casts objectAtIndex:indexPath.row];
    Data *data  = [[Data alloc]init];
    data.title = [myDict objectForKey:@"titleText"];
    data.detail = [myDict objectForKey:@"detailText"];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cellValue = [NSString stringWithFormat:@"%@, %@", data.title, data.detail];
        cell.textLabel.text = cellValue;
    }
    else
    {
        //Load image asynchronously
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          //  NSString *imageUrl = [myDict objectForKey:@"imageURL"];
            //NSURL *url = [NSURL URLWithString:imageUrl];
            //NSData *imageData = [NSData dataWithContentsOfURL:url];
            //dispatch_sync(dispatch_get_main_queue(), ^{
            //UIImage *image = [UIImage imageWithData:imageData];
            //cell.imageView.image = image;
                
                //[tableView beginUpdates];
                //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
                //[tableView endUpdates];
            //});
        //});
        
        NSString *imageUrl = [myDict objectForKey:@"imageURL"];
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        cell.imageView.image = image;
        
        cellValue = [NSString stringWithFormat:@"%@, %@", data.title, data.detail];
        cell.textLabel.text = cellValue;
        
    }
    
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    [cell.textLabel setText:cellValue];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

// UITableView Cell Click
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    mailMessage = cell.textLabel.text;
    NSArray *splitArray = [mailMessage componentsSeparatedByString:@","];
    
    // Email Title
    NSString *emailTitle = [splitArray objectAtIndex:0];
    
    // Email Body
    NSString *messageBody = [splitArray objectAtIndex:1];
    
    // Email Subject
    NSArray *toRecepients = [NSArray arrayWithObject:@"taomalla@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecepients];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
