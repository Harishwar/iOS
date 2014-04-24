//
//  TPLViewController.h
//  SQLite
//
//  Created by Harishwar on 4/24/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface TPLViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *bookname;
@property (strong, nonatomic) IBOutlet UITextField *bookauthor;
- (IBAction)save:(id)sender;
- (IBAction)find:(id)sender;
- (IBAction)clear:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UITextField *bookdesc;
@property (strong, nonatomic) IBOutlet UILabel *savedetails;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;

@end
