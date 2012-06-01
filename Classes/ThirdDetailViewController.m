//
//  ThirdDetailViewController.m
//  MultipleDetailViews
//
//  Created by Chang Alf on 2011/6/24.
//  Copyright 2011Âπ?__MyCompanyName__. All rights reserved.
//

#import "ThirdDetailViewController.h"

#define ZOOM_VIEW_TAG 100
#define ZOOM_STEP 1.5

@implementation ThirdDetailViewController

@synthesize rootViewController, navigationBar, tapOrMove, titleName, detailItem, scrollView, audioPlayer;

UIInterfaceOrientation nowWhat;
float zoomHeight, zoomWidth;
extern int cellIndex;

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
}

-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player error:(NSError *)error
{
}

-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
}

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
        if(timer != nil && [timer isValid]) [timer invalidate];
        
        /*
        timer3 = [NSTimer scheduledTimerWithTimeInterval:screensaver
                                                 target:self
                                               selector:@selector(onTimer3)
                                               userInfo:nil
                                                repeats:NO];
        */

    }
	
}
/*
-(void) onTimer2 {
    
    [timer2 invalidate];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(tapOrMove == false)
    {
        ;
	}
    
}
*/
-(void) onTimer3 {
    
    [timer3 invalidate];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rootViewController.nc1 popToRootViewControllerAnimated:YES];
    [rootViewController Ray:1 whichRoom:@"【公共藝術說明】"];
    [rootViewController.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection: 0] animated:NO scrollPosition:UITableViewScrollPositionNone];   
    cellIndex = 0;
}


- (void)doAnimation {
    
    tapOrMove = false;
    FilesHandlingViewController *fileController = [FilesHandlingViewController new];
    
    [[scrollView viewWithTag:ZOOM_VIEW_TAG] removeFromSuperview];
    
    UIImage *image = [UIImage imageNamed:[fileController RayReadImg]];
    TapDetectingImageView *zoomView = [[TapDetectingImageView alloc] initWithImage:image];
    [zoomView setDelegate:self];
    [zoomView setTag:ZOOM_VIEW_TAG];
    [scrollView addSubview:zoomView];
    [scrollView setContentSize:[zoomView frame].size];
    
    // choose minimum scale so image width fits screen
    float minScale  = [scrollView frame].size.width  / [zoomView frame].size.width;
    [scrollView setMinimumZoomScale:minScale];
    [scrollView setZoomScale:minScale];
    [scrollView setContentOffset:CGPointZero];

    zoomHeight = zoomView.bounds.size.height;
    zoomWidth = zoomView.bounds.size.width;
    
    //***
    //[label setFrame:CGRectMake(0, zoomHeight * minScale, self.view.bounds.size.width - 0, 200)];
    
    [zoomView release];
    
    /*
     // add gesture recognizers to the image view
     UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
     UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
     UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
     
     [doubleTap setNumberOfTapsRequired:2];
     [twoFingerTap setNumberOfTouchesRequired:2];
     
     [imageView addGestureRecognizer:singleTap];
     [imageView addGestureRecognizer:doubleTap];
     [imageView addGestureRecognizer:twoFingerTap];
     
     [singleTap release];
     [doubleTap release];
     [twoFingerTap release];
     */
    // calculate minimum scale to perfectly fit image width, and begin at that scale

    navigationBar.center = CGPointMake(self.view.bounds.size.width + navigationBar.bounds.size.width/2, navigationBar.center.y);
    scrollView.center = CGPointMake(self.view.bounds.size.width + scrollView.bounds.size.width/2, scrollView.center.y);
    [fileController release];
    timer = [NSTimer scheduledTimerWithTimeInterval:aniinterval
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
    [scrollView release];
    [audioPlayer release];
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
    
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Kalimba" ofType:@"mp3"]];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", [error localizedDescription]);
    } 
    else 
    {
        audioPlayer.delegate = self;
    }
    */
    
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
    if(nowWhat == UIInterfaceOrientationPortrait)
    {
        [scrollView setFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, 1000)];
    }
    else
    {
        [scrollView setFrame:CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.frame.size.width, 715)];
    }
    return YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    /*
    if ([titleName isEqualToString:@"傳統客家山歌"]) {
        [audioPlayer play];
    }else{
        [audioPlayer stop];
    }
    */
    
}

-(void) viewWillDisappear:(BOOL)animated {
    /*
    if(timer3 != nil && [timer3 isValid])
        [timer3 invalidate];
    */ 
    //[audioPlayer stop];
    [super viewWillDisappear:animated];
}

- (void)setDetailItem:(id)newDetailItem {
    if (detailItem != newDetailItem) {
        [detailItem release];
        detailItem = [newDetailItem retain];
        
        // Update the view.
        navigationBar.topItem.title = [detailItem description];
		
        //NSString *imageName	= [NSString stringWithFormat:@"%@.jpg",navigationBar.topItem.title];
		//imageView.image = [UIImage imageNamed:imageName];
        
        /*
        if ([navigationBar.topItem.title isEqualToString:@"傳統客家山歌"]) 
        {
            [audioPlayer setCurrentTime:0];
            [audioPlayer play];
        }
        else
        {
            [audioPlayer stop];
        }
        */
        
        [self doAnimation];
    }
    
    if (rootViewController.popoverController != nil) {
        [rootViewController.popoverController dismissPopoverAnimated:YES];
    }

}

#pragma mark UIScrollViewDelegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)PscrollView {
    return [scrollView viewWithTag:ZOOM_VIEW_TAG];
}

/************************************** NOTE **************************************/
/* The following delegate method works around a known bug in zoomToRect:animated: */
/* In the next release after 3.0 this workaround will no longer be necessary      */
/**********************************************************************************/
- (void)scrollViewDidEndZooming:(UIScrollView *)PscrollView withView:(UIView *)view atScale:(float)scale {
    [PscrollView setZoomScale:scale+0.01 animated:NO];
    [PscrollView setZoomScale:scale animated:NO];
    //[label setCenter:CGPointMake(view.center.x, zoomHeight * scale + label.frame.size.height / 2)];
}

#pragma mark TapDetectingImageViewDelegate methods

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    // single tap does nothing for now
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    // double tap zooms in

    float newScale = [scrollView zoomScale] * ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [scrollView zoomToRect:zoomRect animated:YES];

}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {

    // two-finger tap zooms out
    float newScale = [scrollView zoomScale] / ZOOM_STEP;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
    [scrollView zoomToRect:zoomRect animated:YES];

}

#pragma mark Utility methods

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {

    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;

}

-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    /*
    if(timer3 != NULL)
    {
        [timer3 invalidate];
        
    }

    timer3 = [NSTimer scheduledTimerWithTimeInterval:screensaver
                                             target:self
                                           selector:@selector(onTimer3)
                                           userInfo:nil
                                            repeats:NO];
     */
}

@end
