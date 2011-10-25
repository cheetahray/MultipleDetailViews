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
- (void) RayWTF:(NSString *) whichonetxt withoneimg:(NSString *) whichoneimg;
- (NSString *) documentsPath;
- (NSString *) readFromFile:(NSString *) filePath;
- (NSString *) RayReadTxt;
- (NSString *) RayReadImg;
- (void) writeToFile:(NSString *) text withFileName:(NSString *) filePath;

@end

