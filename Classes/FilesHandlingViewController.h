//
//  FilesHandlingViewController.h
//  FilesHandling
//
//  Created by Wei-Meng Lee on 2/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilesHandlingViewController : NSObject {

}

- (NSString *) documentsPath;
- (NSString *) readFromFile:(NSString *) filePath;
- (void) writeToFile:(NSString *) text withFileName:(NSString *) filePath;
- (void) RayWriteFile:(NSString *) fileName;
- (NSString *) RayReadFile;

@end

