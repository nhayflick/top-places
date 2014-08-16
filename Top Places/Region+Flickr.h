//
//  Region+Flickr.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Region.h"

@interface Region (Flickr)
+ (Region *)regionWithFlickObiect:(NSDictionary *)regionObject inManagedObjectContext:(NSManagedObjectContext *)context;


@end
