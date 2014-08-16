//
//  SharedDocumentHandler.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/25/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedDocumentHandler : NSObject
@property NSManagedObjectContext *managedObjectContext;

+ (SharedDocumentHandler *)sharedInstance;
- (UIManagedDocument *)document;
- (NSManagedObjectContext *)context;

@end
