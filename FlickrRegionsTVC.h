//
//  TopPlacesTableViewController.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/17/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface FlickrRegionsTVC : CoreDataTableViewController

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;

@end
