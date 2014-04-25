//
//  TPLViewController.m
//  SQLite
//
//  Created by Harishwar on 4/24/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import "TPLViewController.h"

@interface TPLViewController ()

@end

@implementation TPLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"books.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    //Create or Open SQLite DB
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS BOOKS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, AUTHOR TEXT, DESC TEXT)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Save Details into SQLite
- (IBAction)save:(id)sender {
    sqlite3_stmt    *statement;
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO BOOKS (name, author, desc) VALUES (\"%@\", \"%@\", \"%@\")",
                               _bookname.text, _bookauthor.text, _bookdesc.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt,
                           -1, &statement, NULL);
        
        //Get Time of Book Entry
        NSDate *gettime = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"dd-MM-yyyy hh:mm:ss";
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        //[dateFormatter release];
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            _status.text = @"Added";
            _bookname.text = @"";
            _bookauthor.text = @"";
            _bookdesc.text = @"";
            _savedetails.text=[dateFormatter stringFromDate:gettime];
        } else {
            _status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

//Find matching records with BookName
- (IBAction)find:(id)sender {
    const char *dbpath = [_databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT author, desc FROM books WHERE name=\"%@\"",
                              _bookname.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc]
                                          initWithUTF8String:
                                          (const char *) sqlite3_column_text(
                                                                             statement, 0)];
                _bookauthor.text = addressField;
                NSString *phoneField = [[NSString alloc]
                                        initWithUTF8String:(const char *)
                                        sqlite3_column_text(statement, 1)];
                _bookdesc.text = phoneField;
                _status.text = @"Match found";
            } else {
                _status.text = @"Match not found";
                _bookauthor.text = @"";
                _bookdesc.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

//Clear All Fields
- (IBAction)clear:(id)sender {
    _bookname.text=@"";
    _bookauthor.text=@"";
    _bookdesc.text=@"";
    _status.text=@"";
    _savedetails.text=@"";
}

@end
