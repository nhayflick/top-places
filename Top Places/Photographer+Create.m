//
//  Photographer+Create.m
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Photographer+Create.h"

@implementation Photographer (Create)
+ (Photographer *)photographerWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer = nil;
    
    if ([name length]) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.predicate = [NSPredicate predicateWithFormat:@"name = %d", name];
        
        NSError *error;
        NSArray *resultsArray = [context executeFetchRequest:request error:&error];
        
        if (!resultsArray || error || [resultsArray count] > 1) {
            //handle error
        } else if(resultsArray) {
            photographer = [resultsArray firstObject];
        } else {
            photographer = [NSEntityDescription insertNewObjectForEntityForName:@"Photographer" inManagedObjectContext:context];
            photographer.name = name;
        }
    }
    
    return photographer;
}

@end
