//
//  MPMediaLibrary.h
//  MediaPlayer
//
//  Copyright 2008 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayerDefines.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0

@class MPMediaQuery;

// MPMediaLibrary represents a collection of media on a device, and can be used to fetch items and playlists from the user's synced iTunes library.
// See MPMediaQuery.h for a list of common queries or to build a custom query from a chain of filter predicates.

MP_EXTERN_CLASS @interface MPMediaLibrary : NSObject {
@private
    id _internal;
}

+ (MPMediaLibrary *)defaultMediaLibrary;

// Returns the date at which the media library was last modified.
@property(nonatomic, readonly) NSDate *lastModifiedDate;

// MPMediaLibraryDidChangeNotification will be posted when a sync happens.
- (void)beginGeneratingLibraryChangeNotifications;
- (void)endGeneratingLibraryChangeNotifications;

@end

// Any items or playlists which were previously cached should be re-evaluated from queries when MPMediaLibraryDidChangeNotification is posted.
MP_EXTERN NSString *const MPMediaLibraryDidChangeNotification;

#endif // __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0
