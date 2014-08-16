//
//  Photographer+Create.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/27/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import "Photographer.h"

@interface Photographer (Create)

+(Photographer *)photographerWithName:(NSString *)name inManagedObjectContext:(NSManagedObjectContext *)context;


@end
