//
//  UserDefaults.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/20/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

-(NSArray *)photos
{
    _photos = [[NSUserDefaults standardUserDefaults] arrayForKey:@"FlickrRecentlyViewed"];
    return _photos;
}

// Singleton pattern
+(UserDefaults *)sharedInstance {
    static UserDefaults *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UserDefaults alloc] init];
    });
    return _sharedInstance;
}

-(void)addPhoto:(NSDictionary *)photo
{
    NSArray *defaults = [[NSUserDefaults standardUserDefaults] arrayForKey:@"FlickrRecentlyViewed"];
    NSLog(@"%@", defaults);
    NSMutableArray *mutableDefaults;
    if (!defaults) {
        mutableDefaults = [[NSMutableArray alloc] init];
    } else {
        mutableDefaults = [defaults mutableCopy];
    }
    if (![mutableDefaults containsObject:photo]) {
        NSLog(@"sync");
        [mutableDefaults insertObject:photo atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:mutableDefaults forKey:@"FlickrRecentlyViewed"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
