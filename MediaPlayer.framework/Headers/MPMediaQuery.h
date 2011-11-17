//
//  MPMediaQuery.h
//  MediaPlayer
//
//  Copyright 2008 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayerDefines.h>

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0

@class MPMediaQueryInternal, MPMediaPredicate, MPMediaPropertyPredicateInternal;

enum {
    MPMediaGroupingTitle,
    MPMediaGroupingAlbum,
    MPMediaGroupingArtist,
    MPMediaGroupingAlbumArtist,
    MPMediaGroupingComposer,
    MPMediaGroupingGenre,
    MPMediaGroupingPlaylist,
    MPMediaGroupingPodcastTitle
};
typedef NSInteger MPMediaGrouping;

// MPMediaQuery represents a collection of items or playlists determined by a chain of MPMediaPredicate objects.

MP_EXTERN_CLASS @interface MPMediaQuery : NSObject <NSCoding, NSCopying> {
@private
    MPMediaQueryInternal *_internal;
}

- (id)init;
- (id)initWithFilterPredicates:(NSSet *)filterPredicates;
@property(nonatomic, retain) NSSet *filterPredicates;

- (void)addFilterPredicate:(MPMediaPredicate *)predicate;
- (void)removeFilterPredicate:(MPMediaPredicate *)predicate;

// Returns an array of MPMediaItems matching the query filter predicates.
// If no items match this method returns an empty array, otherwise returns nil if an error prevents the items from being fetched.
@property(nonatomic, readonly) NSArray *items;

// Returns an array of MPMediaItemCollections matching the query filter predicates. The collections are grouped by the groupingType.
@property(nonatomic, readonly) NSArray *collections;

// The property used to group collections, defaults to MPMediaGroupingTitle.
@property(nonatomic) MPMediaGrouping groupingType;

// Base queries which can be used directly or as the basis for custom queries.
// The groupingType for these queries is preset to the appropriate type for the query.
+ (MPMediaQuery *)albumsQuery;
+ (MPMediaQuery *)artistsQuery;
+ (MPMediaQuery *)songsQuery;
+ (MPMediaQuery *)playlistsQuery;
+ (MPMediaQuery *)podcastsQuery;
+ (MPMediaQuery *)audiobooksQuery;
+ (MPMediaQuery *)compilationsQuery;
+ (MPMediaQuery *)composersQuery;
+ (MPMediaQuery *)genresQuery;

@end

// ------------------------------------------------------------------------
// MPMediaPredicate is an abstract class that allows filtering media in an MPMediaQuery.
// See the concrete subclass MPMediaPropertyPredicate for filtering options.

MP_EXTERN_CLASS @interface MPMediaPredicate : NSObject <NSCoding> {}
@end

// ------------------------------------------------------------------------
// MPMediaPropertyPredicate allows filtering based on a specific property value of an item or collection.
// See MPMediaItem.h and MPMediaPlaylist.h for a list of properties.

enum {
    MPMediaPredicateComparisonEqualTo,
    MPMediaPredicateComparisonContains
};
typedef NSInteger MPMediaPredicateComparison;

MP_EXTERN_CLASS @interface MPMediaPropertyPredicate : MPMediaPredicate {
@private
    MPMediaPropertyPredicateInternal *_internal;
}

+ (MPMediaPropertyPredicate *)predicateWithValue:(id)value forProperty:(NSString *)property; // comparisonType is MPMediaPredicateComparisonEqualTo
+ (MPMediaPropertyPredicate *)predicateWithValue:(id)value forProperty:(NSString *)property comparisonType:(MPMediaPredicateComparison)comparisonType;

@property(nonatomic, readonly, copy) NSString *property;
@property(nonatomic, readonly, copy) id value;
@property(nonatomic, readonly) MPMediaPredicateComparison comparisonType;

@end

#endif // __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_0
