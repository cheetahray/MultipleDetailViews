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

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	/*
    imageView.center = CGPointMake(imageView.center.x - 20,
                                   imageView.center.y);
    
    label.center = CGPointMake(label.center.x - 20,
                                   label.center.y);
    navigationBar.center = CGPointMake(navigationBar.center.x - 25,
        navigationBar.center.y);
     */
    scrollView.center = CGPointMake(scrollView.center.x - 20,
                                    scrollView.center.y);
    
	[UIView commitAnimations];
    
    if (scrollView.center.x <= self.view.bounds.size.width / 2 + 20 )   
    {
        /*
        imageView.center = CGPointMake(self.view.bounds.size.width/2 ,
                                       imageView.center.y);
        navigationBar.center = CGPointMake(imageView.center.x ,
                                           navigationBar.center.y);
        label.center = CGPointMake(imageView.center.x ,
                                           label.center.y);
        */
        scrollView.center = CGPointMake(scrollView.bounds.size.width/2, scrollView.center.y);
        [timer invalidate];
    }
	
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
    imageView.center = CGPointMake(self.view.bounds.size.width + imageView.bounds.size.width/2 ,
                                   imageView.center.y);
    navigationBar.center = CGPointMake(self.view.bounds.size.width + navigationBar.bounds.size.width/2 ,
                                       navigationBar.center.y);
    label.center = CGPointMake(self.view.bounds.size.width + label.bounds.size.width/2 ,
                                       label.center.y);
    */
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
    [imageView setFrame:CGRectMake(0, navigationBar.frame.size.height , imageView.image.size.width, imageView.image.size.height)];
    label.center = CGPointMake( scrollView.bounds.size.width/2,
                               imageView.frame.origin.y + imageView.frame.size.height + label.frame.size.height/2);
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

//---fired when the user finger(s) touches the screen---
-(void) touchesBegan: (NSSet *) touches withEvent: (UIEvent *) event {
	
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
    tapOrMove = true;
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
			//---single touch---
        case 1: {
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			
            //---compare the touches---
            switch ([touch tapCount])
            {
					//---single tap---
                case 1: {
                    tapOrMove = false;
                    
                    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                             target:self
                                                           selector:@selector(onTimer2)
                                                           userInfo:nil
                                                            repeats:NO];

                } break;
					
					//---double tap---
                case 2: {
                    
                } break;
            }
        }  break;
			
            //---double-touch---
        case 2: {
            //---get info of first touch---
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			
            //---get info of second touch---
            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
            //---get the points touched---
            CGPoint touch1PT = [touch1 locationInView:[self view]];
            CGPoint touch2PT = [touch2 locationInView:[self view]];
			
            NSLog(@"Touch1: %.0f, %.0f", touch1PT.x, touch1PT.y);
            NSLog(@"Touch2: %.0f, %.0f", touch2PT.x, touch2PT.y);
			
			//---record the distance made by the two touches---
            
        } break;
    }
}

//---fired when the user moved his finger(s) on the screen---
-(void) touchesMoved: (NSSet *) touches withEvent: (UIEvent *) event {
	
    //---get all touches on the screen---
    NSSet *allTouches = [event allTouches];
	tapOrMove = true;
    //---compare the number of touches on the screen---
    switch ([allTouches count])
    {
			//---single touch---
        case 1: {
            //---get info of the touch---
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
			
            //---check to see if the image is being touched---
            CGPoint touchPoint = [touch locationInView:[self view]];
			/*
             if (touchPoint.x > imageView.frame.origin.x &&
             touchPoint.x < imageView.frame.origin.x +
             imageView.frame.size.width &&
             touchPoint.y > imageView.frame.origin.y &&
             touchPoint.y <imageView.frame.origin.y +
             imageView.frame.size.height) {
             [imageView setCenter:touchPoint];
             }
             */
        }  break;
			
			//---double-touch---
        case 2: {
            //---get info of first touch---
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			
            //---get info of second touch---
            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
            //---get the points touched---
            CGPoint touch1PT = [touch1 locationInView:[self view]];
            CGPoint touch2PT = [touch2 locationInView:[self view]];
			
            NSLog(@"Touch1: %.0f, %.0f", touch1PT.x, touch1PT.y);
            NSLog(@"Touch2: %.0f, %.0f", touch2PT.x, touch2PT.y);
			/*
             CGFloat currentDistance = [self distanceBetweenTwoPoints: touch1PT
             toPoint: touch2PT];
             
             //---zoom in---
             if (currentDistance > originalDistance)
             {
             imageView.frame = CGRectMake(imageView.frame.origin.x - 4,
             imageView.frame.origin.y - 4,
             imageView.frame.size.width + 8,
             imageView.frame.size.height + 8);
             }
             else {
             //---zoom out---
             imageView.frame = CGRectMake(imageView.frame.origin.x + 4,
             imageView.frame.origin.y + 4,
             imageView.frame.size.width - 8,
             imageView.frame.size.height - 8);
             }
             originalDistance = currentDistance;
             */
        } break;
    }
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
