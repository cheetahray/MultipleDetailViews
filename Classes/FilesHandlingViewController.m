//
//  FilesHandlingViewController.m
//  FilesHandling
//
//  Created by Wei-Meng Lee on 2/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "FilesHandlingViewController.h"

@implementation FilesHandlingViewController

//---finds the path to the application's Documents directory---
-(NSString *) documentsPath {
    NSArray *paths = 
	    NSSearchPathForDirectoriesInDomains(
		    NSDocumentDirectory, NSUserDomainMask, YES);
	
    NSString *documentsDir = [paths objectAtIndex:0];
    return documentsDir;
}

//---read content from a specified file path---
-(NSString *) readFromFile:(NSString *) filePath {
    //---check if file exists---
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] == FALSE) {
        [self RayWriteFile:filePath];
    }
    NSArray *array = [[NSArray alloc] initWithContentsOfFile: filePath];
    NSString *data = [NSString stringWithFormat:@"%@",
                      [array objectAtIndex:0]];
    [array release];
    return data;
}

//---write content into a specified file path---
-(void) writeToFile:(NSString *) text withFileName:(NSString *) filePath {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:text];
    [array writeToFile:filePath atomically:YES];
    [array release];
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) RayWriteFile:(NSString *) fileName {
    
    //---write something to the file---
    [self writeToFile:@"a string of text" withFileName:fileName];
    
}

-(NSString *) RayReadFile {
    
    //---formulate filename---
    NSString *fileName = [[self documentsPath]
						  stringByAppendingPathComponent:@"data.txt"];
    
    
    //---read it back---
    return [self readFromFile:fileName];

}

- RayReadTable {
    
    //---get the path to the property list file---
    NSString *plistFileName = [[self documentsPath]
							   stringByAppendingPathComponent:@"Apps.plist"];
	
    //---if the property list file can be found---
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistFileName] == FALSE)
    {
        
        //---load the property list from the Resources folder---
        NSString *pListPath = [[NSBundle mainBundle] pathForResource:@"Apps"
															  ofType:@"plist"];
        
		NSDictionary *dict = [[NSDictionary alloc]
							  initWithContentsOfFile:pListPath];
        
		//---make a mutable copy of the dictionary object---
        NSMutableDictionary *copyOfDict = [dict mutableCopy];
        
     	//---get all the different categories---
        NSArray *categoriesArray = [[copyOfDict allKeys]
									sortedArrayUsingSelector:@selector(compare:)];
        //---for each category---
        for (NSString *category in categoriesArray) {
            
			//---get all the app titles in that category---
            NSArray *titles = [dict valueForKey:category];
            
			//---make a mutable copy of the array---
            NSMutableArray *mutableTitles = [titles mutableCopy];
            
			//---add a new title to the category---
            [mutableTitles addObject:@"New App title"];
            
			//---set the array back to the dictionary object---
            [copyOfDict setObject:mutableTitles forKey:category];
            [mutableTitles release];
        }
         
        [copyOfDict writeToFile:plistFileName atomically:YES];
        [dict release];
        [copyOfDict release];

    }

    //---load the content of the property list file into a NSDictionary
    // object---
    NSDictionary *dict = [[NSDictionary alloc]
                          initWithContentsOfFile:plistFileName];
    
    
    //---for each category---
    for (NSString *category in dict)
    {
        NSLog(category);
        NSLog(@"========");
        //---return all titles in an array---
        NSArray *titles = [dict valueForKey:category];
        //---print out all the titles in that category---
        for (NSString *title in titles)
        {
            NSLog(title);
        }
    }
    [dict release];

}


@end
