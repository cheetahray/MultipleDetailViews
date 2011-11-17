//
//  MPMoviePlayerViewController.h
//  MediaPlayer
//
//  Copyright 2009-2010 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayerDefines.h>
#import <UIKit/UIViewController.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2

@class MPMoviePlayerController;

MP_EXTERN_CLASS @interface MPMoviePlayerViewController : UIViewController {
@private
    id _internal;
}

- (id)initWithContentURL:(NSURL *)contentURL;

@property(nonatomic, readonly) MPMoviePlayerController *moviePlayer;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation; // Default is YES.
@end

// -----------------------------------------------------------------------------
// UIViewController Additions
// Additions to present a fullscreen movie player as a modal view controller using the standard movie player transition.

@interface UIViewController (MPMoviePlayerViewController)

- (void)presentMoviePlayerViewControllerAnimated:(MPMoviePlayerViewController *)moviePlayerViewController;
- (void)dismissMoviePlayerViewControllerAnimated;

@end

#endif // __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
