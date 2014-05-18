//
//  TPLCoreDataViewController.m
//  SQLite
//
//  Created by Harishwar on 5/17/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import "TPLCoreDataViewController.h"
#import "TPLAppDelegate.h"
#import <CoreData/CoreData.h>

@interface TPLCoreDataViewController ()

@end

@implementation TPLCoreDataViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(id)sender {
    TPLAppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newBook;
    newBook = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Books"
                  inManagedObjectContext:context];
    NSDate *gettime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MM-yyyy hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    [newBook setValue: _bookname.text forKey:@"bookname"];
    [newBook setValue: _bookauthor.text forKey:@"bookauthor"];
    [newBook setValue: _bookdesc.text forKey:@"bookdesc"];
    [newBook setValue: _bookpub.text forKey:@"bookpub"];
    [newBook setValue: _bookisbn.text forKey:@"bookisbn"];
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
    _bookpub.text = @"";
    _bookisbn.text = @"";
    NSError *error;
    [context save:&error];
    _status.text = @"Book Details Saved";
    _savetime.text=[dateFormatter stringFromDate:gettime];
}

- (IBAction)find:(id)sender {
    id delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [delegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Books"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(bookname = %@)",
     _bookname.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _status.text = @"No matches";
    } else {
        matches = objects[0];
        _bookauthor.text = [matches valueForKey:@"bookauthor"];
        _bookdesc.text = [matches valueForKey:@"bookdesc"];
        _bookpub.text = [matches valueForKey:@"bookauthor"];
        _bookisbn.text = [matches valueForKey:@"bookdesc"];
        _status.text = [NSString stringWithFormat:
                        @"%lu matches found", (unsigned long)[objects count]];
        _savetime.text = @"";
    }
}

- (IBAction)clear:(id)sender {
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
    _bookpub.text = @"";
    _bookisbn.text = @"";
    _savetime.text = @"";
    _status.text = @"";
}
@end
