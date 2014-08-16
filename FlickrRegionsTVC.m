//
//  TopPlacesTableViewController.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/17/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "FlickrRegionsTVC.h"
#import "FlickrFetcher.h"
#import "TopPhotosByLocationFlickrPhotosTVC.h"
#import "Region+Flickr.h"
#import "PhotoDatabaseAvailability.h"

@interface FlickrRegionsTVC ()

@end

@implementation FlickrRegionsTVC

- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSLog(@"setManagedObjectContext");
    _managedObjectContext = managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
    request.predicate = nil;
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"Title" ascending:YES selector:@selector(localizedStandardCompare:)]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) { 
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib
{
        [[NSNotificationCenter defaultCenter] addObserverForName:PhotoDatabaseAvailabilityNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *note) {
                                                          self.managedObjectContext = note.userInfo[PhotoDatabaseAvailabilityContext];
                                                      }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Region Cell"];
    Region *region = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = region.title;
    
    return cell;
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
//    if ([segue.destinationViewController isKindOfClass:[TopPhotosByLocationFlickrPhotosTVC class]]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        TopPhotosByLocationFlickrPhotosTVC *destinationVC = segue.destinationViewController;
//        NSDictionary *location = [self locationAtRow:indexPath.row inSection:indexPath.section];
//        NSString *locationID = [location valueForKey:FLICKR_PLACE_ID];
//        destinationVC.locationID = locationID;
//        destinationVC.navigationItem.title = [location valueForKey:@"title"];
//    }
}

@end
