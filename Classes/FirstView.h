//
//  FirstView.h
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/22.
//  Copyright 2011年 ETAT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@class RootViewController;

@interface FirstView : UIViewController {   

    UINavigationBar *navigationBar;
    RootViewController *rootViewController;   
    BOOL tapOrMove; 
    NSTimer *timer;
    UIImageView *imageView;
    
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (readwrite) BOOL tapOrMove;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
