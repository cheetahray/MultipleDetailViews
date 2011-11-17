//
//  MPVolumeView.h
//  MediaPlayer
//
//  Copyright 2008 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayerDefines.h>

@class MPVolumeViewInternal;

MP_EXTERN_CLASS @interface MPVolumeView : UIView <NSCoding> {
@private
    MPVolumeViewInternal *_internal;
}

- (CGSize)sizeThatFits:(CGSize)size;

@end
