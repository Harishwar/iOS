//
//  FileOps.h
//  NSFileManager
//
//  Created by Harishwar on 5/18/14.
//  Copyright (c) 2014 com.harishwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileOps : NSObject{
    NSFileManager *fileMgr;
    NSString *homeDir;
    NSString *filename;
    NSString *filepath;
}

@property(nonatomic,retain) NSFileManager *fileMgr;
@property(nonatomic,retain) NSString *homeDir;
@property(nonatomic,retain) NSString *filename;
@property(nonatomic,retain) NSString *filepath;

-(NSString *) GetDocumentDirectory;
-(void)WriteToStringFile:(NSMutableString *)textToWrite;
-(NSString *) readFromFile;
-(NSString *) setFilename;

@end
