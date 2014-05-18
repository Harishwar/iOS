//
//  HRTViewController.m
//  NSFileManager
//
//  Created by Harishwar on 5/18/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import "HRTViewController.h"
#import "FileOps.h"

@interface HRTViewController ()

@end

@implementation HRTViewController

- (void)viewDidLoad
{
    NSString *docsDir;
    NSArray *dirPaths;
    NSFileManager *filemgr;
    
    filemgr = [NSFileManager defaultManager];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    _dataFilePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"data.archive"]];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNSFile:(id)sender {
    FileOps *files = [[FileOps alloc] init];
    
    NSString *newBook = [NSString stringWithFormat:@"Name: %@ \nAuthor: %@ \nDescription: %@",_bookname.text, _bookauthor.text, _bookdesc.text];
    
    [files WriteToStringFile:[newBook mutableCopy]];
    _status.text = @"Book Details Saved";
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
}

-(BOOL) textFieldShouldReturn:(UITextField *) aTxtFld{
    if(aTxtFld==self.bookname)
    {
        [aTxtFld resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)saveNSKeyed:(id)sender {
    NSMutableArray *bookArray;

    bookArray = [[NSMutableArray alloc] init];
    [bookArray addObject:_bookname.text];
    [bookArray addObject:_bookauthor.text];
    [bookArray addObject:_bookdesc.text];
    [NSKeyedArchiver archiveRootObject:bookArray toFile:_dataFilePath];
    
    _status.text = @"Book Details Saved";
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
}

- (IBAction)clear:(id)sender {
    _status.text = @"";
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
}
- (IBAction)findNSFile:(id)sender {
    FileOps *readFile = [[FileOps alloc] init];
    self.status.text = [readFile readFromFile];
    _bookname.text = @"";
    _bookauthor.text = @"";
    _bookdesc.text = @"";
}

- (IBAction)findNSKeyed:(id)sender {
    NSFileManager *filemgr;
    
    filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _dataFilePath]) {
   
        NSMutableArray *detailsArray;
        detailsArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_dataFilePath];
    
        NSString *newBook = [NSString stringWithFormat:@"Name: %@ \nAuthor: %@ \nDescription: %@",detailsArray[0], detailsArray[1], detailsArray[2]];
    
        _status.text = newBook;
        _bookname.text = @"";
        _bookauthor.text = @"";
        _bookdesc.text = @"";
    } else {
        _status.text = @"Archive File Not Found";
        _bookname.text = @"";
        _bookauthor.text = @"";
        _bookdesc.text = @"";
    }
}
@end
