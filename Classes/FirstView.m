//
//  FirstView.m
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/22.
//  Copyright 2011年 ETAT. All rights reserved.
//

#import "FirstView.h"

@implementation FirstView

@synthesize rootViewController, navigationBar, tapOrMove, imageView;

int areaType = -1;
CGFloat originalDistance, diffDistanceX, diffDistanceY;
float ratiox, ratioy, originalwidth, originalheight;
bool canTouch;

-(void) onTimer2 {
    
    [timer invalidate];
    canTouch = true;
    if(tapOrMove == false && areaType > 0)
    {
        [rootViewController Ray:1 whichRoom:nil];
        switch (areaType) {
            case 1:
                rootViewController.firstViewController.detailItem = @"Training Day";
                break;
            case 2:
                rootViewController.firstViewController.detailItem = @"Remember the Titans";
                break;
            case 3:
                rootViewController.firstViewController.detailItem = @"John Q";
                break;
        }
	}
    [rootViewController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:areaType inSection: 0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(CGFloat) distanceBetweenTwoPoints:(CGPoint)fromPoint toPoint:(CGPoint)toPoint {
	
    float lengthX = fromPoint.x - toPoint.x;
    float lengthY = fromPoint.y - toPoint.y;
    return sqrt((lengthX * lengthX) + (lengthY * lengthY));	
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
			CGPoint touchPT = [touch locationInView:[self view]];
            //---compare the touches---
            switch ([touch tapCount])
            {
					//---single tap---
                case 1: {
                    tapOrMove = false;
                    if(true == canTouch)
                        timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                             target:self
                                                           selector:@selector(onTimer2)
                                                           userInfo:nil
                                                            repeats:NO];
                    canTouch = false;
                    if(touchPT.x >= 10 * ratiox + imageView.frame.origin.x && touchPT.y >= 130 * ratioy + imageView.frame.origin.y && touchPT.x <= 200 * ratiox + imageView.frame.origin.x && touchPT.y <= 260 * ratioy + imageView.frame.origin.y)
                        areaType = 1;
                    else if(touchPT.x >= 245 * ratiox + imageView.frame.origin.x && touchPT.y >= 25 * ratioy + imageView.frame.origin.y && touchPT.x <= 460 * ratiox + imageView.frame.origin.x && touchPT.y <= 140 * ratioy + imageView.frame.origin.y)
                        areaType = 2;
                    else if(touchPT.x >= 380 * ratiox + imageView.frame.origin.x && touchPT.y >= 350 * ratioy + imageView.frame.origin.y && touchPT.x <= 660 * ratiox + imageView.frame.origin.x && touchPT.y <= 470 * ratioy + imageView.frame.origin.y)
                        areaType = 3;
                    else
                        areaType = 0;
                    diffDistanceX = touchPT.x-imageView.center.x;
                    diffDistanceY = touchPT.y-imageView.center.y;
                } break;
					
					//---double tap---
                case 2: {
                    //imageView.contentMode = UIViewContentModeCenter;
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
            #ifdef zoomInOut
			originalDistance  = [self distanceBetweenTwoPoints:touch1PT toPoint:touch2PT];
            #endif
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
			
            if (touchPoint.x > imageView.frame.origin.x &&
                touchPoint.x < imageView.frame.origin.x +
				imageView.frame.size.width &&
                touchPoint.y > imageView.frame.origin.y &&
                touchPoint.y <imageView.frame.origin.y +
				imageView.frame.size.height) {
                [imageView setCenter:CGPointMake(touchPoint.x - diffDistanceX, touchPoint.y - diffDistanceY)];
            }
        }  break;
			
			//---double-touch---
        case 2: {
            #ifdef zoomInOut
            //---get info of first touch---
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
			
            //---get info of second touch---
            UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
			
            //---get the points touched---
            CGPoint touch1PT = [touch1 locationInView:[self view]];
            CGPoint touch2PT = [touch2 locationInView:[self view]];
            
            NSLog(@"Touch1: %.0f, %.0f", touch1PT.x, touch1PT.y);
            NSLog(@"Touch2: %.0f, %.0f", touch2PT.x, touch2PT.y);
			
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
            ratiox = imageView.bounds.size.width / originalwidth;
            ratioy = imageView.bounds.size.height / originalheight;
            #endif
        } break;
    }
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
    // Do any additional setup after loading the view from its nib.
    originalwidth = imageView.frame.size.width;
    originalheight = imageView.frame.size.height;
    ratiox = 1.0;
    ratioy = 1.0;
    canTouch = true;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Add the popover button to the left navigation item.
    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Remove the popover button.
    [navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
}

@end
