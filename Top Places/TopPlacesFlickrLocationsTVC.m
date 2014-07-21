//
//  TopPlacesFlickrPhotosTVCViewController.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/17/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "TopPlacesFlickrLocationsTVC.h"
#import "TopPhotosByLocationFlickrPhotosTVC.h"

@interface TopPlacesFlickrLocationsTVC ()

@end

@implementation TopPlacesFlickrLocationsTVC
- (IBAction)refresh:(id)sender {
    [self fetchLocations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return [self.countries count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSDictionary *locations = [self locationsForCountry:section];
    return [locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Flickr Location Cell" forIndexPath:indexPath];
    NSDictionary *location = [self locationAtRow:indexPath.row inSection:indexPath.section];
    cell.textLabel.text = [FlickrFetcher cityOfPlace:location];
    cell.detailTextLabel.text = [FlickrFetcher countryOfPlace:location];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[self.sortedLocations allKeys] objectAtIndex:section];
}


- (NSDictionary *)locationsForCountry:(NSInteger)index
{
    NSString *sectionKey = [self.countries objectAtIndex:index];
    NSDictionary *locations = [self.sortedLocations valueForKey:sectionKey];
    return locations;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchLocations];
}

- (void)fetchLocations
{
    [self.refreshControl beginRefreshing];
    self.locations = nil;
    NSURL *url = [FlickrFetcher URLforTopPlaces];
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        if (jsonResults) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
            NSArray *locations = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PLACES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
                self.locations = locations;
            });
        }
    });
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
