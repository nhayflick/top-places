//
//  RecentPhotosFlickrPhotosTVC.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/20/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "RecentPhotosFlickrPhotosTVC.h"
#import "UserDefaults.h"

@interface RecentPhotosFlickrPhotosTVC ()

@end

@implementation RecentPhotosFlickrPhotosTVC

- (void)fetchPhotos
{
    UserDefaults *userDefaults = [UserDefaults sharedInstance];
    NSArray *photos = userDefaults.photos;
    NSLog(@"fetch defaults");
    self.photos = photos;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchPhotos];
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
