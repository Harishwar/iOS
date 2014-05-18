//
//  HRTViewController.h
//  NSFileManager
//
//  Created by Harishwar on 5/18/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *bookname;
@property (strong, nonatomic) IBOutlet UITextField *bookauthor;
@property (strong, nonatomic) IBOutlet UITextView *bookdesc;
- (IBAction)saveNSFile:(id)sender;
- (IBAction)saveNSKeyed:(id)sender;
- (IBAction)clear:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *status;
- (IBAction)findNSFile:(id)sender;
- (IBAction)findNSKeyed:(id)sender;
@property (strong, nonatomic) NSString *dataFilePath;

@end
