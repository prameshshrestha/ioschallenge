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
    NSString *jsonUrl;
    NSMutableDictionary *dict;
    NSDictionary *trackInfo;
    NSMutableArray *name;
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
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *array = [json objectForKey:@"GetAllTrackingPointsResult"];
        
        dict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i < array.count; i++)
        {
            trackInfo = [array objectAtIndex:i];
            NSString *ttype = [trackInfo objectForKey:@"TType"];
            NSString *tname = [trackInfo objectForKey:@"TName"];
            [dict setValue:tname forKey:ttype];
        }
        name = [[NSMutableArray alloc]init];
        for (id key in dict)
        {
            id value = [dict objectForKey:key];
            [name addObject:value];
        }
    }
    else
    {
        UIAlertView *err = [[UIAlertView alloc]initWithTitle:@"Server Error" message:@"Cannot connect to the server" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [err show];
    }
}

// UITableViewDelegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [name count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *barcode = [name objectAtIndex:[indexPath row]];
    // Create custom color
    UIColor *color = [UIColor colorWithRed:0/255.0f green:150/255.0f blue:225/255.0f alpha:1.0f];
    cell.textLabel.textColor = color;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];    [cell.textLabel setText:barcode];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
