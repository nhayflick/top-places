//
//  Region+Flickr.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Region+Flickr.h"
#import "FlickrFetcher.h"

@implementation Region (Flickr)

+ (Region *)regionWithFlickrObject:(NSDictionary *)regionObject inManagedObjectContext:(NSManagedObjectContext *)context
{
    Region *region = nil;
    
    NSString *name = [regionObject valueForKeyPath:FLICKR_PLACE_NAME];
    NSString *placeID = [regionObject valueForKey:FLICKR_PLACE_ID];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
    request.predicate = [NSPredicate predicateWithFormat:@"placeID = %d", placeID];
    
    NSError *error;
    NSArray *matchesArray = [context executeFetchRequest:request error:&error];
    
    if (!matchesArray || error || [matchesArray count] > 1) {
        // handle error
    } else if([matchesArray count]) {
        NSLog(@"%@", placeID);
        region = [matchesArray lastObject];
    } else {
        NSLog(@"matched");
        region = [NSEntityDescription insertNewObjectForEntityForName:@"Region" inManagedObjectContext:context];
        
        region.title = name;
        region.placeID = placeID;
    }
    
    return region;
}

@end
