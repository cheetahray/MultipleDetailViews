#import "FirstDetailViewController.h"

#define X1 30
#define Y1 280
#define W1 208
#define H1 140
#define X2 280
#define Y2 170
#define W2 240
#define H2 130
#define X3 425
#define Y3 511
#define W3 299
#define H3 119

@implementation FirstDetailViewController

@synthesize detailItem, imageView, rootViewController, navigationBar, tapOrMove;

#pragma mark -
#pragma mark View lifecycle

int ISurrender = 0;
int areaType;
CGFloat originalDistance, diffDistanceX, diffDistanceY;
float ratiox, ratioy, originalwidth, originalheight;
bool canTouch = TRUE;
bool stupid = TRUE;

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	ISurrender-=20;
    imageView.center = CGPointMake(ISurrender,
                                   imageView.center.y);
    
    navigationBar.center = CGPointMake(navigationBar.center.x - 20,
                                           navigationBar.center.y);
    
	[UIView commitAnimations];
    
    if (navigationBar.center.x <= self.view.bounds.size.width / 2 )   
    {
        imageView.center = CGPointMake(imageView.bounds.size.width/2 ,
                                       imageView.center.y);
        navigationBar.center = CGPointMake(navigationBar.bounds.size.width/2 ,
                                           navigationBar.center.y);
        canTouch = true;
        [timer invalidate];
    }
	
}

-(void) onTimer2 {
    
    if(areaType > 0)
    {
        switch (areaType) {
            case 1:
                [rootViewController Ray:2 whichRoom:@"【客迎．傳情】"];
                break;
            case 2:
                [rootViewController Ray:2 whichRoom:@"【花漾．綠動】"];
                break;
            case 3:
                [rootViewController Ray:2 whichRoom:@"【家客．融蘊】"];
                break;
        }
        [rootViewController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:areaType inSection: 0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        [timer2 invalidate];
	}
    
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
                    if(true == canTouch){
                        timer2 = [NSTimer scheduledTimerWithTimeInterval:singletap
                                                             target:self
                                                           selector:@selector(onTimer2)
                                                           userInfo:nil
                                                            repeats:NO];
                                        if(touchPT.x >= X1 * ratiox + imageView.frame.origin.x && touchPT.y >= Y1 * ratioy + imageView.frame.origin.y && touchPT.x <= X1+W1 * ratiox + imageView.frame.origin.x && touchPT.y <= Y1+H1 * ratioy + imageView.frame.origin.y)
                    {
                        areaType = 1;
                        rectangle = [[UIView alloc] initWithFrame:CGRectMake(X1, Y1, W1, H1)]; 
                    }
                    else if(touchPT.x >= X2 * ratiox + imageView.frame.origin.x && touchPT.y >= Y2 * ratioy + imageView.frame.origin.y && touchPT.x <= X2+W2 * ratiox + imageView.frame.origin.x && touchPT.y <= Y2+H2 * ratioy + imageView.frame.origin.y)
                    {
                        areaType = 2;
                        rectangle = [[UIView alloc] initWithFrame:CGRectMake(X2, Y2, W2, H2)]; 
                    }
                    else if(touchPT.x >= X3 * ratiox + imageView.frame.origin.x && touchPT.y >= Y3 * ratioy + imageView.frame.origin.y && touchPT.x <= X3+W3 * ratiox + imageView.frame.origin.x && touchPT.y <= Y3+H3 * ratioy + imageView.frame.origin.y)
                    {
                        areaType = 3;
                        rectangle = [[UIView alloc] initWithFrame:CGRectMake(X3, Y3, W3, H3)]; 
                    }
                    else
                        areaType = 0;
                    diffDistanceX = touchPT.x-imageView.center.x;
                    diffDistanceY = touchPT.y-imageView.center.y;
                    
                    rectangle.backgroundColor = [UIColor lightTextColor]; //color the rectangle
                    [imageView addSubview:rectangle]; //add the rectangle to your image
                        
                    if(areaType>0) canTouch = false;

                    }
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
            #ifdef zoomInOut
			//---record the distance made by the two touches---
			originalDistance  = [self distanceBetweenTwoPoints:touch1PT toPoint:touch2PT];
            #endif
        } break;
    }
}
#ifdef zoomInOut
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
        } break;
    }
}
#endif
- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        
        [detailItem release];
        detailItem = [newDetailItem retain];
        
		// Update the view.
        if ([newDetailItem isEqualToString:@"Training Day"])
        {
            navigationBar.topItem.title = @"【客迎．傳情】";
            //imageView.contentMode = UIViewContentModeCenter;
        }
        else if ([newDetailItem isEqualToString:@"HomePage-001"])
        {
            navigationBar.topItem.title = @"【公共藝術說明】";
            //imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        else if ([newDetailItem isEqualToString:@"Remember the Titans"])
        {
            navigationBar.topItem.title = @"【花漾．綠動】";
            //imageView.contentMode = UIViewContentModeCenter;
        }
        else if ([newDetailItem isEqualToString:@"John Q"])
        {
            navigationBar.topItem.title = @"【家客．融蘊】";
            //imageView.contentMode = UIViewContentModeCenter;
        }
        else
            navigationBar.topItem.title = [detailItem description];
		/*
        NSString *imageName	= [NSString stringWithFormat:@"%@.jpg",[detailItem description] ];
        imageView.image = [UIImage imageNamed:imageName];
        */
        originalwidth = imageView.frame.size.width;
        originalheight = imageView.frame.size.height;
        
        [self doAnimation];
    }
    
}

- (void)viewDidUnload {
	[super viewDidUnload];
	//[self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ratiox = 1.0;
    ratioy = 1.0;
    //canTouch = true;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(TRUE == stupid)
    {
        [rootViewController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection: 0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        stupid = FALSE;
    }
}

- (void)doAnimation {
    if([navigationBar.topItem.title isEqualToString:@"【公共藝術說明】"])
    {
        tapOrMove = false;
    
        //[imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
        imageView.center = CGPointMake(self.view.bounds.size.width + imageView.bounds.size.width/2 , imageView.center.y);
        
        ISurrender = imageView.center.x;
        
        navigationBar.center = CGPointMake(self.view.bounds.size.width + navigationBar.bounds.size.width/2, navigationBar.center.y);
    
        timer = [NSTimer scheduledTimerWithTimeInterval:aniinterval
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
    }
    else
        [rootViewController Ray:2 whichRoom:navigationBar.topItem.title];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [navigationBar release];
    [detailItem release];
    [imageView release];
    [super dealloc];
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
