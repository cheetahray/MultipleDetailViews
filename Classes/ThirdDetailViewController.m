//
//  ThirdDetailViewController.m
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ThirdDetailViewController.h"
#import "FilesHandlingViewController.h"

@implementation ThirdDetailViewController

@synthesize rootViewController, navigationBar, tapOrMove, imageView, label, titleName, detailItem, scrollView;

UIInterfaceOrientation nowWhat;

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	/*
    imageView.center = CGPointMake(imageView.center.x - 20,
                                   imageView.center.y);
    
    label.center = CGPointMake(label.center.x - 20,
                                   label.center.y);
     */
    navigationBar.center = CGPointMake(navigationBar.center.x - 20,
                                       navigationBar.center.y);
    scrollView.center = CGPointMake(scrollView.center.x - 20,
                                    scrollView.center.y);
    
	[UIView commitAnimations];
    
    if (navigationBar.center.x <= self.view.bounds.size.width / 2 )   
    {
        /*
        imageView.center = CGPointMake(self.view.bounds.size.width/2 ,
                                       imageView.center.y);
        label.center = CGPointMake(imageView.center.x ,
                                           label.center.y);
        */
        navigationBar.center = CGPointMake(navigationBar.bounds.size.width/2 ,
                                           navigationBar.center.y);
        scrollView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.center.y);
        [timer invalidate];

        label.contentOffset = CGPointMake(0, 0);
    }
	
    label.contentOffset = CGPointMake(0, 1);

}

-(void) onTimer2 {
    
    [timer invalidate];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(tapOrMove == false)
    {
        ;
	}
    
}

- (void)doAnimation {
    tapOrMove = false;
    /*
    imageView.center = CGPointMake(self.view.bounds.size.width + imageView.bounds.size.width/2 , imageView.center.y);
    label.center = CGPointMake(self.view.bounds.size.width + label.bounds.size.width/2 ,
                                       label.center.y);
    */
    navigationBar.center = CGPointMake(self.view.bounds.size.width + navigationBar.bounds.size.width/2, navigationBar.center.y);
    scrollView.center = CGPointMake(self.view.bounds.size.width + scrollView.bounds.size.width/2, scrollView.center.y);
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [navigationBar release];
    [imageView release];
    [fileController release];
    [scrollView release];
    [label release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    fileController = [FilesHandlingViewController new];
    label.text = [fileController RayReadTxt];
    imageView.image = [UIImage imageNamed:[fileController RayReadImg]];
    [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
    
    [label setFrame:CGRectMake(0, imageView.bounds.size.height, self.view.bounds.size.width - 70, 200)];
    
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    
    int myWidth = 0;
    int myHeight = (navigationBar.frame.size.height + imageView.image.size.height + lable.frame.size.height);
    myWidth = (applicationFrame.size.width <= imageView.image.size.width)?imageView.image.size.width:applicationFrame.size.width;
    if(nowWhat == UIInterfaceOrientationPortrait)
    {
        myHeight = (applicationFrame.size.height <= myHeight)?myHeight:applicationFrame.size.height;
    }
    else
    {
        myHeight = (applicationFrame.size.height <= myHeight)?myHeight+200:applicationFrame.size.height+300;
    }
    
    scrollView.contentSize = CGSizeMake(myWidth, myHeight);  
    
    [self doAnimation];
    navigationBar.topItem.title = titleName;
    if(rootViewController.rootPopoverButtonItem != nil)
        rootViewController.rootPopoverButtonItem.title = rootViewController.secondViewController.titleName;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Add the popover button to the left navigation item.
    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Remove the popover button.
    [navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    nowWhat = interfaceOrientation;
    return YES;
}

- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        navigationBar.topItem.title = [detailItem description];
		
        //NSString *imageName	= [NSString stringWithFormat:@"%@.jpg",navigationBar.topItem.title];
		//imageView.image = [UIImage imageNamed:imageName];
        [self doAnimation];
    }

    if (rootViewController.popoverController != nil) {
        [rootViewController.popoverController dismissPopoverAnimated:YES];
    }

}

@end
