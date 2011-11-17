//
//  MPMediaPlaylist.h
//  MediaPlayer
//
//  Copyright 2008 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayerDefines.h>
#import <MediaPlayer/MPMediaItemCollection.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0

@class MPMediaItem, MPMediaPlaylistInternal;

// A playlist may have any number of MPMediaPlaylistAttributes associated.
enum {
    MPMediaPlaylistAttributeNone    = 0,
    MPMediaPlaylistAttributeOnTheGo = (1 << 0), // if set, the playlist was created on a device rather than synced from iTunes
    MPMediaPlaylistAttributeSmart   = (1 << 1),
    MPMediaPlaylistAttributeGenius  = (1 << 2)
};
typedef NSInteger MPMediaPlaylistAttribute;

// An MPMediaPlaylist is a collection of related MPMediaItems in an MPMediaLibrary.
// Playlists have a unique identifier which persists across application launches.

MP_EXTERN_CLASS @interface MPMediaPlaylist : MPMediaItemCollection {
@private
    MPMediaPlaylistInternal *_playlistInternal;
}

// Returns YES for item properties which can be used to construct MPMediaPropertyPredicates.
+ (BOOL)canFilterByProperty:(NSString *)property;

// Returns the value for the given item property, see the playlist properties listing below.
- (id)valueForProperty:(NSString *)property;

@end

// Playlist properties can be used with -valueForProperty: to fetch metadata about an MPMediaPlaylist.
// Properties marked filterable can also be used to build MPMediaPropertyPredicates (see MPMediaQuery.h).

MP_EXTERN NSString *const MPMediaPlaylistPropertyPersistentID;       // @"playlistPersistentID",    NSNumber of uint64_t (unsigned long long),           filterable
MP_EXTERN NSString *const MPMediaPlaylistPropertyName;               // @"name",                    NSString,                                            filterable
MP_EXTERN NSString *const MPMediaPlaylistPropertyPlaylistAttributes; // @"playlistAttributes",      NSNumber of MPMediaPlaylistAttribute (NSInteger),    filterable

// For playlists with attribute MPMediaPlaylistAttributeGenius, the seedItems are the MPMediaItems which were used to the generate the playlist.
// Returns nil for playlists without MPMediaPlaylistAttributeGenius set.
MP_EXTERN NSString *const MPMediaPlaylistPropertySeedItems;          // @"seedItems",               NSArray of MPMediaItems

#endif // __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0
