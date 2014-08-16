//
//  Photo+Flickr.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Photo+Flickr.h"
#import "FlickrFetcher.h"
#import "Photographer+Create.h"
#import "Region+Flickr.h"

@implementation Photo (Flickr)
+ (Photo *)photoWithFlickrObject:(NSDictionary *)photoDictionary inManagedObjectContext:(NSManagedObjectContext *)context {
    Photo *photo = nil;
    
    NSString *unique = [photoDictionary valueForKey:FLICKR_PHOTO_ID];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    
    NSError *error;
    NSArray *matchesArray = [context executeFetchRequest:request error:&error];
    
    if (!matchesArray || error || [matchesArray count]) {
        //Handle errors
    } else if([matchesArray count] == 1) {
        //Fetch photo
        photo = [matchesArray firstObject];
    } else {
        NSLog(@"loading photo");

        //Insert photo
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:context];
        
        photo.unique = unique;
        photo.title = [photoDictionary valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.subtitle = [photoDictionary valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL = [[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatSquare] absoluteString];
        //Download and store thumbnail here
        
        //Insert photographer
        NSString *photographerName = [photoDictionary valueForKeyPath:FLICKR_PHOTO_OWNER];
        photo.whoTook = [Photographer photographerWithName:photographerName inManagedObjectContext:context];
       
        //Fetch & insert region
        NSString *placeID = [photoDictionary valueForKeyPath:FLICKR_PHOTO_PLACE_ID];
        dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetcher", NULL);
        dispatch_async(fetchQ, ^{
            NSData *data = [NSData dataWithContentsOfURL:[FlickrFetcher URLforInformationAboutPlace:placeID]];
            if (data) {
                NSDictionary *regionObject = [NSJSONSerialization JSONObjectWithData:data options:1 error:nil];
                NSLog(@"%@", regionObject);
                if (regionObject) {
                    NSLog(@"%@", regionObject);
                    photo.region = [Region regionWithFlickrData:regionObject inManagedObjectContext:[photo managedObjectContext]];
                }
            }
        });
    }
    return photo;
}

+(void)loadPhotosWithFlickrDataArray:(NSArray *)photosArray intoManagedObjectContext:(NSManagedObjectContext *)context
{
    int numberOfPhotos = [photosArray count];
    for (int i = 0; i < numberOfPhotos; i++) {
        [self photoWithFlickrObject:photosArray[i] inManagedObjectContext:context];
    }
}

@end
