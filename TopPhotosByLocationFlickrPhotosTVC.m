//
//  TopPhotosByLocationFlickrPhotosTVC.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/19/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "TopPhotosByLocationFlickrPhotosTVC.h"
#import "FlickrFetcher.h"

@interface TopPhotosByLocationFlickrPhotosTVC ()

@end

@implementation TopPhotosByLocationFlickrPhotosTVC

- (void)fetchPhotosForLocation:(NSString *)locationID
{
    NSURL *url = [FlickrFetcher URLforPhotosInPlace:locationID maxResults:50];
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResults = [NSData dataWithContentsOfURL:url];
        if (jsonResults) {
            NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
            NSArray *photos = [propertyListResults valueForKeyPath:@"photos.photo"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.photos = photos;
            });
        }
    });
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
    NSLog(@"%@", self.locationID);
    [self fetchPhotosForLocation:self.locationID];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
