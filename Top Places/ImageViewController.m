//
//  ImageViewController.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/19/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate, UISplitViewControllerDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ImageViewController

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    [self zoomToFitImage:self.image];
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    self.image = NULL;
    _imageUrl = imageUrl;
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr Fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            if (imageUrl == self.imageUrl) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                });
            }
        }
    });
}

- (UIImageView *)imageView
{
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

- (UIImage *)image
{
    return self.imageView.image;
}


- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [self.activityIndicator stopAnimating];
}

-(void)zoomToFitImage:(UIImage *)image
{
    double wideImageSize = self.scrollView.bounds.size.width / image.size.height;
    double tallImageSize = (self.scrollView.bounds.size.height - self.navigationController.navigationBar.frame.size.height - self.tabBarController.tabBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height) / image.size.width;
    if (wideImageSize > tallImageSize) self.scrollView.zoomScale = wideImageSize;
    else self.scrollView.zoomScale = tallImageSize;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

#pragma mark - UISplitViewControllerDelegate
-(void)awakeFromNib {
    [super awakeFromNib];
    self.splitViewController.delegate = self;
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return UIInterfaceOrientationIsPortrait(orientation);
}

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Photos";
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    self.navigationItem.leftBarButtonItem = nil;
}
@end
