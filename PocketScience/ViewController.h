//
//  ViewController.h
//  PocketScience
//
//  Created by pramesh on 4/17/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *jsonSearchBar;

@end
