//
//  MOGScale.h
//  musicofthegaps
//
//  Created by Alex Gordon on 21/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MOGCore.h"

@interface MOGScale : NSObject

@property (copy) NSString* name;
@property (assign) std::vector<int> gaps;

+ (NSArray*)names;
+ (id)named:(NSString*)name;
+ (id)major;
+ (id)melodic;
+ (id)harmoinc;
+ (id)wholetone;
+ (id)chromatic;
+ (id)pentatonic;

- (id)rotate:(int)amount;

- (unsigned)hash;

@end
