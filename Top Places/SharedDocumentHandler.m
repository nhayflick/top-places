//
//  SharedDocumentHandler.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/25/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "SharedDocumentHandler.h"

@interface SharedDocumentHandler()

@property (nonatomic, strong) UIManagedDocument *document;

@end

@implementation SharedDocumentHandler


+(SharedDocumentHandler *)sharedInstance
{
    static SharedDocumentHandler *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SharedDocumentHandler alloc] init];
    });
    return _sharedInstance;
}


-(UIManagedDocument *)document
{
    if (!_document) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        
        NSString *documentName = @"TopPlacesDocument";
        NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
        self.document = [[UIManagedDocument alloc] initWithFileURL:url];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
            [self.document openWithCompletionHandler:^(BOOL success) {
                if (success) [self documentIsReady];
            }];
        } else {
            [self.document saveToURL:url
               forSaveOperation:UIDocumentSaveForCreating
              completionHandler:^(BOOL success) {
                  if (success) [self documentIsReady];
              }];
        }
    }
    return _document;
}

-(NSManagedObjectContext *)context
{
    return [self.document managedObjectContext];
}

-(void)documentIsReady
{
    if (self.document.documentState == UIDocumentStateNormal) {
       self.managedObjectContext = self.document.managedObjectContext;
    }
}

@end
