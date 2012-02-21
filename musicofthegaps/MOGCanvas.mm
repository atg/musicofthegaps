//
//  MOGCanvas.m
//  musicofthegaps
//
//  Created by Alex Gordon on 21/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MOGCanvas.h"
#import "MOGSegment.h"


@implementation MOGCanvas
@synthesize pixels_per_second;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        pixels_per_second = 100;
    }
    
    return self;
}
- (void)awakeFromNib {
    MOGSegment* segment = [[MOGSegment alloc] init];
    [segment setFrame:[self bounds]];
    [segment setAutoresizingMask:NSViewHeightSizable];
    [self addSubview:segment];
    
    segment = [[MOGSegment alloc] init];
    [segment setFrame:[self bounds]];
    [segment setAutoresizingMask:NSViewHeightSizable];
    segment.scale = mog_scale::major().rotate(5);
    [self addSubview:segment];
    
    [self layout];
}

- (void)layout {
    CGFloat x = 0.0;
    for (MOGSegment* seg in [self subviews]) {
        CGFloat w = seg.seconds * pixels_per_second;
        NSRect r = [seg frame];
        r.origin.x = x;
        r.size.width = w;
        [seg setFrame:r];
        x += w;
    }
}
- (void)drawRect:(NSRect)dirtyRect {
    // 
}

@end
