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
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    NSURL *restUrl = [NSURL URLWithString:@"http://www.nousguideinc.com/12323123dsfsdf/4358h.json"];
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:restUrl options:NSDataReadingUncached error:&error];
    if(!error)
    {
        // create NSDictionary from the JSON data
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        // Create a new array to hold Cast
        casts = [jsonDictionary objectForKey:@"cast"];
        
        for (int i = 0; i < casts.count; i++)
        {
            NSDictionary *cast = [casts objectAtIndex:i];
            NSString *first = [cast objectForKey:@"titleText"];
            NSString *last = [cast objectForKey:@"detailText"];
        }
        
    }
}

// UITableViewDelegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [casts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //[[cell textLabel] setText:[casts objectAtIndex:[indexPath row]]];
    //NSString *barcode = [casts objectAtIndex:[indexPath row]];
    NSDictionary *myDict = [casts objectAtIndex:indexPath.row];
    cell.textLabel.text = [myDict objectForKey:@"titleText"];
    
    
    
    
    
    
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];    //[cell.textLabel setText:barcode];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
