//
//  FlickrPhotosTVC.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/19/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "FlickrPhotosTVC.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"
#import "UserDefaults.h"

@interface FlickrPhotosTVC ()

@end

@implementation FlickrPhotosTVC

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (NSDictionary *)getPhotoAtRow:(NSInteger)row
{
    NSDictionary *photo = [self.photos objectAtIndex:row];
    return photo;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.refreshControl beginRefreshing];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photos count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Flickr Photo Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *photo = [self getPhotoAtRow:indexPath.row];
    if ([[photo valueForKey:FLICKR_PHOTO_TITLE] length]) {
        cell.textLabel.text = [photo valueForKey:FLICKR_PHOTO_TITLE];
        cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    } else if([[photo valueForKey:FLICKR_PHOTO_DESCRIPTION] length]) {
        cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
        cell.detailTextLabel.text = @"";
    } else {
        cell.textLabel.text = @"Unknown";
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

- (void) savePhotoToUserDefaults:(NSDictionary *)photo
{
    UserDefaults *userDefaults = [UserDefaults sharedInstance];
    [userDefaults addPhoto:photo];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *photo = [self getPhotoAtRow:indexPath.row];
        ImageViewController *ivc = segue.destinationViewController;
        [self prepareImageViewController:ivc toDisplayPhoto:photo];
    }
}

- (void)prepareImageViewController:(ImageViewController *)ivc toDisplayPhoto:(NSDictionary *)photo
{
    NSURL *url = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    ivc.imageUrl = url;
    ivc.navigationItem.title = [photo valueForKey:FLICKR_PHOTO_TITLE];
    ivc.backButtonTitle = self.title;
    [self savePhotoToUserDefaults:photo];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    NSDictionary *photo = [self getPhotoAtRow:indexPath.row];
    if ([detail isKindOfClass:[UINavigationController class]]) {
        detail = [((UINavigationController *)detail).viewControllers firstObject];
    }
    if ([detail isKindOfClass:[ImageViewController class]]) {
        [self prepareImageViewController:detail toDisplayPhoto:photo];
    }
}

@end
