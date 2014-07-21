//
//  TopPlacesTableViewController.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/17/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrLocationsTVC : UITableViewController
@property (strong, nonatomic) NSArray *locations; //of Flickr locations NSDictionaries
@property (strong, nonatomic) NSDictionary *sortedLocations;  //of Flickr locations NSDictionaries
@property (strong, nonatomic) NSArray *countries;

- (NSDictionary *)locationAtRow:(NSInteger)row inSection:(NSInteger)section;

@end
