//
//  Photo.h
//  Top Places
//
//  Created by Nathan Hayflick on 8/11/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer, Region;

@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * imageThumbnail;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) Region *region;
@property (nonatomic, retain) Photographer *whoTook;

@end
