//
//  TPLCoreDataViewController.h
//  SQLite
//
//  Created by Harishwar on 5/17/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TPLCoreDataViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *bookname;
@property (strong, nonatomic) IBOutlet UITextField *bookauthor;
@property (strong, nonatomic) IBOutlet UITextField *bookdesc;
@property (strong, nonatomic) IBOutlet UITextField *bookpub;
@property (strong, nonatomic) IBOutlet UITextField *bookisbn;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *savetime;
- (IBAction)save:(id)sender;
- (IBAction)find:(id)sender;
- (IBAction)clear:(id)sender;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
