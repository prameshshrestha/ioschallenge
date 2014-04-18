//
//  ViewController.h
//  PocketScience
//
//  Created by pramesh on 4/17/14.
//  Copyright (c) 2014 pramesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *jsonSearchBar;

- (IBAction)sendEmail:(id)sender;
@end
