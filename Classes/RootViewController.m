
/*
     File: RootViewController.m
 Abstract: A table view controller that manages two rows. Selecting a row creates a new detail view controller that is added to the split view controller.
 
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

#import "RootViewController.h"


@implementation RootViewController

@synthesize popoverController, splitViewController, rootPopoverButtonItem, firstViewController, secondViewController, oneOrTwo, detailViewController, nc1, nc2, thirdViewController;

NSMutableArray *listOfMovies;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    listOfMovies = [[NSMutableArray alloc] init];
    [listOfMovies addObject:@"【首頁】"];
	[listOfMovies addObject:@"【客迎．傳情】"];
	[listOfMovies addObject:@"【花漾．綠動】"];
    [listOfMovies addObject:@"【家客．融蘊】"];
    
    // Set the content size for the popover: there are just two rows in the table view, so set to rowHeight*2.
    self.contentSizeForViewInPopover = CGSizeMake(320, 700);
    
    oneOrTwo = 0;
}


-(void) viewDidUnload {
	[super viewDidUnload];
	
	self.splitViewController = nil;
	self.rootPopoverButtonItem = nil;
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc {
    
    // Keep references to the popover controller and the popover button, and tell the detail view controller to show the button.
    switch (oneOrTwo) {
        case 3:
            barButtonItem.title = nc2.titleName;
            break;
        default:
            barButtonItem.title = @"客家文化會館";
            break;
    }

    self.popoverController = pc;
    self.rootPopoverButtonItem = barButtonItem;
    detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController showRootPopoverButtonItem:rootPopoverButtonItem];
}


- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
 
    // Nil out references to the popover controller and the popover button, and tell the detail view controller to hide the button.
    detailViewController = [splitViewController.viewControllers objectAtIndex:1];
    [detailViewController invalidateRootPopoverButtonItem:rootPopoverButtonItem];
    self.popoverController = nil;
    self.rootPopoverButtonItem = nil;
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    // Two sections, one for each detail view controller.
    return [listOfMovies count];//2;
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RootViewControllerCellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set appropriate labels for the cells.
    /*
    if (indexPath.row == 0) {
        cell.textLabel.text = @"First Detail View Controller";
    }
    else {
        cell.textLabel.text = @"Second Detail View Controller";
    }
    */
    cell.textLabel.text = [listOfMovies objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark -
#pragma mark Table view selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Dismiss the popover if it's present.
    [self Ray:1 whichRoom:nil];
    switch (indexPath.row) {
        case 0:
            firstViewController.detailItem = @"HomePage-001";
            break;
        case 1:
            firstViewController.detailItem = @"Training Day";
            break;
        case 2:
            firstViewController.detailItem = @"Remember the Titans";
            break;
        case 3:
            firstViewController.detailItem = @"John Q";
            break;
        default:
            firstViewController.detailItem = [NSString stringWithFormat:@"%@", [listOfMovies objectAtIndex:indexPath.row]];
            break;
    }
    
}

- (void) Ray : (int) setInt whichRoom:(NSString *)indexRoom {

    if(setInt != oneOrTwo)
    {
        
        switch (setInt) {
            case 1:
                firstViewController = [[FirstDetailViewController alloc] initWithNibName:@"FirstDetailView" bundle:nil];
                firstViewController.rootViewController = self;
                detailViewController = firstViewController;
                if (popoverController != nil) {
                    [popoverController dismissPopoverAnimated:YES];
                }
                break;
                
            case 2:
                secondViewController = [[SecondDetailViewController alloc] initWithNibName:@"SecondDetailView" bundle:nil];
                secondViewController.rootViewController = self;
                secondViewController.titleName = indexRoom;
                detailViewController = secondViewController;
                // Dismiss the popover if it's present.
                if (popoverController != nil) {
                    [popoverController dismissPopoverAnimated:YES];
                }
                break;
                
            case 3:
                thirdViewController = [[ThirdDetailViewController alloc] initWithNibName:@"ThirdDetailViewController" bundle:nil];
                thirdViewController.rootViewController = self;
                thirdViewController.titleName = indexRoom;
                detailViewController = thirdViewController;
                break;
                
            default:
                
                break;
        }
        
        oneOrTwo = setInt;
    
        // Update the split view controller's view controllers array.
        
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.navigationController, detailViewController, nil];
        splitViewController.viewControllers = viewControllers;
        [viewControllers release];
        
        // Configure the new view controller's popover button (after the view has been displayed and its toolbar/navigation bar has been created).
        if (rootPopoverButtonItem != nil) {
            [detailViewController showRootPopoverButtonItem:self.rootPopoverButtonItem];
        }
        
        [detailViewController release];

    }
    
}

- (void) LoadThreeView:(NSString *)indexTitle {
    //if (self.nc2 == nil)
    //{
        nc2 = [[SecondDetailViewController alloc] initWithNibName:@"SecondDetailView" bundle:[NSBundle mainBundle]];
        nc2.rootViewController = self;
        nc2.titleName = secondViewController.titleName;

    [self Ray:3 whichRoom:indexTitle];
    //[view2 release];       
    //}
    [nc1 pushViewController:self.nc2 animated:YES];
    [nc2 release];
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [popoverController release];
    [rootPopoverButtonItem release];
    [listOfMovies release];
    [firstViewController release];
    [secondViewController release];
    [nc1 release];
    [super dealloc];
}

@end
