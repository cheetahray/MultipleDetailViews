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
-(void) RayWTF:(NSString *)whichonetxt withoneimg:(NSString *)whichoneimg {
    
    [self writeToFile:whichonetxt withFileName:[[self documentsPath] stringByAppendingPathComponent:@"whichonetxt.txt"]];
    
    [self writeToFile:whichoneimg withFileName:[[self documentsPath] stringByAppendingPathComponent:@"whichoneimg.txt"]];
}

//---read content from a specified file path---
-(NSString *) readFromFile:(NSString *) filePath {
    
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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/
/*
- (void) RayWriteFile:(NSString *) fileName {
    
    //---write something to the file---
    [self writeToFile:@"a string of text" withFileName:fileName];
    
}
*/
-(NSString *) RayReadTxt {
    NSString *filePath = [self documentsPath];
    //---check if file exists---
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"1_1.txt"]] == FALSE) {
        [self writeToFile:@"作品設置點為入口空橋，具有迎賓意象，將傳統剪紙的門箋轉化排列於入口玻璃空橋頂，參觀賓客進入展場過程中，沐浴於陽光照射下繽紛五彩的吉祥意象下。" withFileName:[filePath stringByAppendingPathComponent:@"1_1.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"1_2.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"1_2.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"2_2.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"2_2.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"2_3.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"2_3.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"2_4.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"2_4.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"2_5.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"2_5.txt"]];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"3_3.txt"]] == FALSE) {
        [self writeToFile:@" " withFileName:[filePath stringByAppendingPathComponent:@"3_3.txt"]];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"2_1.txt"]] == FALSE) {
        [self writeToFile:@"客家文化中心的建築主要以「尊重自然」、「因地制宜」為概念主軸，建築線條隨基地所在的丘陵蜿蜒起伏，【花漾．綠動】公共藝術作品運用了玻璃的穿透感和折射性與水池倒影結合，整體作品與建築物融入於大自然之中。以幾何面的裝置造形，透過特定視角與水面映像呈現花朵的意象，並藉由風力轉動每一角度的觀看面向，不但突破了雕塑品的定點單一觀看方式，且不拘於形地佇立於大自然中。" withFileName:[filePath stringByAppendingPathComponent:@"2_1.txt"]];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"3_1.txt"]] == FALSE) {
        [self writeToFile:@"" withFileName:[filePath stringByAppendingPathComponent:@"3_1.txt"]];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:[filePath stringByAppendingPathComponent:@"3_2.txt"]] == FALSE) {
        [self writeToFile:@"陶瓷馬賽克拼貼設置於前廣場階梯「垂直立面」，不干擾觀眾座位與配合園區建築及景觀，位在不同角度及高度觀看時，圖案略有變化。" withFileName:[filePath stringByAppendingPathComponent:@"3_2.txt"]];
    }
    
    //---formulate filename---
    NSString *fileName = [filePath stringByAppendingPathComponent:@"whichonetxt.txt"];
    
    
    //---read it back---
    return [self readFromFile:[filePath stringByAppendingPathComponent:[self readFromFile:fileName]]];

}

-(NSString *) RayReadImg {
    
    //---formulate filename---
    NSString *fileName = [self readFromFile:[[self documentsPath]
						  stringByAppendingPathComponent:@"whichoneimg.txt"]];
    
    
    //---read it back---
    return fileName;
    
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
