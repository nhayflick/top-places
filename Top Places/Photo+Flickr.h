//
//  Photo+Flickr.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Photo.h"

@interface Photo (Flickr)
+ (Photo *)photoWithFlickrObject:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)loadPhotosWithFlickrDataArray:(NSArray *)photosArray intoManagedObjectContext:(NSManagedObjectContext *)context;

@end
