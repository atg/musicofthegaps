//
//  MOGSegment.h
//  musicofthegaps
//
//  Created by Alex Gordon on 21/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MOGCore.h"

@interface MOGSegment : NSView

@property (assign) CGFloat seconds;
@property (assign) mog_scale scale;
@property (assign) std::vector<mog_note> notes;

@end
