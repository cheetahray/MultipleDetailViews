//
//  ThirdDetailViewController.h
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "FilesHandlingViewController.h"

@class RootViewController;

@interface ThirdDetailViewController : UIViewController {
    
    UINavigationBar *navigationBar;
    RootViewController *rootViewController;   
    NSTimer *timer;
    UIImageView *imageView;
    BOOL tapOrMove;  
    FilesHandlingViewController *fileController;
    UILabel *lable;
    NSString *titleName;
    id detailItem;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (readwrite) BOOL tapOrMove;
@property (nonatomic, retain) NSString *titleName;
@property (nonatomic, retain) id detailItem;

@end
