//
//  ViewController.m
//  PocketScience
//
//  Created by pramesh on 4/17/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray *casts;
    NSArray *searchResults;
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
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [casts filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
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
    
    NSDictionary *myDict = [casts objectAtIndex:indexPath.row];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        NSString *cellValue = [NSString stringWithFormat:@"%@, %@",[myDict objectForKey:@"titleText"], [myDict objectForKey:@"detailText"]];
        cell.textLabel.text = cellValue;
    }
    else
    {
        
    }
    
    
    NSString *imageUrl = [myDict objectForKey:@"imageURL"];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    NSString *cellValue = [NSString stringWithFormat:@"%@, %@",[myDict objectForKey:@"titleText"], [myDict objectForKey:@"detailText"]];
    cell.textLabel.text = cellValue;
    
    
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    [cell.textLabel setText:cellValue];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
