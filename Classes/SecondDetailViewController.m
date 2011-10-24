
/*
     File: SecondDetailViewController.m
 Abstract: A simple view controller that adopts the SubstitutableDetailViewController protocol defined by RootViewController.
 It's responsible for adding and removing the popover button in response to rotation. This view controller uses a navigation bar.
 
  Version: 1.1
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
 */

#import "SecondDetailViewController.h"

@implementation SecondDetailViewController

@synthesize rootViewController, navigationBar, tapOrMove, imageView, movieTitles, years, tableView, label, titleName, thirdName, scrollView;

#pragma mark -
#pragma mark View lifecycle

-(void) onTimer {
    
	[UIView beginAnimations:@"my_own_animation" context:nil];
	[UIView setAnimationDuration:1];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
    /*
     imageView.center = CGPointMake(imageView.center.x + 20,
                                   imageView.center.y);
    
    tableView.center = CGPointMake(tableView.center.x + 5,
                                   tableView.center.y);
    */
	navigationBar.center = CGPointMake(navigationBar.center.x + 25,
                                       navigationBar.center.y);
    
    [UIView commitAnimations];
    
    if (imageView.center.x >= self.view.bounds.size.width / 2 )   
    {
        /*
        imageView.center = CGPointMake(imageView.bounds.size.width/2 ,
                                       imageView.center.y);
        tableView.center = CGPointMake(tableView.bounds.size.width/2 ,
                                       tableView.center.y);
        */
        navigationBar.center = CGPointMake(navigationBar.bounds.size.width/2 ,
                                           navigationBar.center.y);
        [timer invalidate];
    }
	
}

-(void) onTimer2 {
    
    [timer invalidate];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(tapOrMove == false)
    {
        switch (rootViewController.oneOrTwo) {
            case 2:
                [rootViewController LoadThreeView:thirdName];
                break;
            case 3:
                rootViewController.thirdViewController.detailItem = thirdName;
                break;
            default:
                break;
        }
    }
    
}

- (void)doAnimation {
    tapOrMove = false;
    /*
    imageView.center = CGPointMake( -imageView.image.size.width/2 ,
                                   14 + navigationBar.bounds.size.height + imageView.frame.size.height/2);
    [tableView setFrame:CGRectMake(0, 0, 200, 200)];
    tableView.center = CGPointMake( -tableView.bounds.size.width/2 ,
                                   imageView.frame.origin.y + imageView.frame.size.height + tableView.bounds.size.height/2 - 58);
    */
    navigationBar.center = CGPointMake( -navigationBar.bounds.size.width/2 ,
                                       navigationBar.center.y);
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01
											 target:self
										   selector:@selector(onTimer)
										   userInfo:nil
											repeats:YES];
}

-(void) viewDidUnload {
	[super viewDidUnload];
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer
        // in the navigation stack.  
        if(rootViewController.oneOrTwo == 3)
        {
            [rootViewController Ray:2 whichRoom:titleName];
            [rootViewController.secondViewController doAnimation];
        }
    }
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    //---path to the property list file---
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Movies" 
													 ofType:@"plist"];
    //---load the list into the dictionary---
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    //---save the dictionary object to the property---
    self.movieTitles = dic;
    [dic release];
    
    //---get all the keys in the dictionary object and sort them---
    NSArray *array = [[movieTitles allKeys] 
					  sortedArrayUsingSelector:@selector(compare:)];
    //---save the keys in the years property---
    self.years = array;	
    
    [super viewDidLoad];
    
    NSString *imageName;
    if ([titleName isEqualToString:@"【客迎．傳情】"])
    {
        imageName = @"Training Day.jpg";
        label.text = @"造型與構作:「手工彩色玻璃」與「傳統客家山歌」呈現的視覺、影像與音樂構成客家印象之迎賓長廊空間。\n空間裝置：藝術手工彩色玻璃迎賓\n聲響裝置：客家山歌等傳統歌謠之［空間性重組］"; 
        [label setFrame:CGRectMake(0, 0, 690, 100)];
        [tableView setFrame:CGRectMake(0, 0, 730, 160)];
    }
    else if ([titleName isEqualToString:@"【花漾．綠動】"])
    {
        imageName = @"Remember the Titans.jpg";
        label.text = @"造型與構作:象徵四季花語之大型裝置雕塑作品\n客家文化中心的建築主要以「尊重自然」、「因地制宜」為概念主軸，建築線條隨基地所在的丘陵蜿蜒起伏，【花漾．綠動】公共藝術作品運用了玻璃的穿透感和折射性與水池倒影結合，整體作品與建築物融入於大自然之中。以幾何面的裝置造形，透過特定視角與水面映像呈現花朵的意象，並藉由風力轉動每一角度的觀看面向，不但突破了雕塑品的定點單一觀看方式，且不拘於形地佇立於大自然中。"; 
        [label setFrame:CGRectMake(0, 0, 690, 140)];
        [tableView setFrame:CGRectMake(0, 0, 730, 180)];
    }
    else if ([titleName isEqualToString:@"【家客．融蘊】"])
    {
        imageName = @"John Q.jpg";
    }
    imageView.image = [UIImage imageNamed:imageName];
    [imageView setFrame:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
    
    if(rootViewController.oneOrTwo == 3)
    {
        self.title = titleName;
        [navigationBar setHidden:TRUE];
        scrollView.center = CGPointMake( scrollView.center.x , scrollView.center.y - 44); 
        imageView.center = CGPointMake( self.view.bounds.size.width/2 ,
                                       14 + navigationBar.bounds.size.height + imageView.frame.size.height/2);
        tableView.center = CGPointMake( self.view.bounds.size.width/2 ,
                                       imageView.frame.origin.y + imageView.frame.size.height + tableView.bounds.size.height/2 - 68);        
    }
    else
    {
        navigationBar.topItem.title = titleName;        
        imageView.center = CGPointMake( imageView.image.size.width/2 ,
                                       14 + navigationBar.bounds.size.height + imageView.frame.size.height/2);
        label.center = CGPointMake( label.bounds.size.width/2 ,
                                   imageView.frame.origin.y + imageView.frame.size.height + label.frame.size.height/2 - 62);
        tableView.center = CGPointMake( tableView.bounds.size.width/2 ,
                                       imageView.frame.origin.y + imageView.frame.size.height + label.frame.size.height + tableView.bounds.size.height/2 - 62);        
    }
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    scrollView.contentSize = CGSizeMake(applicationFrame.size.width, 
                                        applicationFrame.size.height + 200);  
    
    if(rootViewController.rootPopoverButtonItem != nil)
    {
        switch (rootViewController.oneOrTwo) {
            case 3:
                rootViewController.rootPopoverButtonItem.title = titleName;
                break;
            default:
                rootViewController.rootPopoverButtonItem.title = @"客家文化會館";
                break;
        }
        
    }
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
#pragma mark Managing the popover
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    // Return the number of sections.
    //return 1;
    return [years count];    
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return 10;
		//---check the current year based on the section index---
		NSString *year = [years objectAtIndex:section];
		//---returns the movies in that year as an array---
		NSArray *movieSection = [movieTitles objectForKey:year];
		//---return the number of movies for that year as the number of rows in that 
		// section ---
		return [movieSection count];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [navigationBar release];
    [imageView release];
    [movieTitles release];
    [years release];
    [scrollView release];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell.
	
    //---get the year---
    NSString *year = [years objectAtIndex:[indexPath section]];
    //---get the list of movies for that year---
    NSArray *movieSection = [movieTitles objectForKey:year];
    //---get the particular movie based on that row---
    cell.textLabel.text = [movieSection objectAtIndex:[indexPath row]]; 
	
    UIImage *image = [UIImage imageNamed:@"apple.jpeg"];
    cell.imageView.image = image;

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //---get the year as the section header---	
	NSString *year = [years objectAtIndex:section];
	return year;
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

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
    //detailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
    tapOrMove = false;
    NSString *year = [years objectAtIndex:[indexPath section]];
    //---get the list of movies for that year---
    NSArray *movieSection = [movieTitles objectForKey:year];
    //---get the particular movie based on that row---
    thirdName = [movieSection objectAtIndex:[indexPath row]];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(onTimer2)
                                           userInfo:nil
                                            repeats:NO];

}

@end
