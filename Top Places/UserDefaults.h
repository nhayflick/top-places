//
//  UserDefaults.h
//  Top Places
//
//  Created by Nathan Hayflick on 7/20/14.
//  Copyright (c) 2014 fissionmailed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

@property (strong, nonatomic)NSArray *photos;

+(UserDefaults *)sharedInstance;
-(void)addPhoto:(NSDictionary *)photo;

@end
