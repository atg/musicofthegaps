//
//  MOGSegment.m
//  musicofthegaps
//
//  Created by Alex Gordon on 21/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MOGSegment.h"

@implementation MOGSegment

@synthesize seconds;
@synthesize scale;
@synthesize notes;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        scale = mog_scale::melodic();
        seconds = 3;
    }
    
    return self;
}

- (NSMenu *)menuForEvent:(NSEvent *)event {
    NSMenu* menu = [[NSMenu alloc] initWithTitle:@"Scale"];
    
    [menu addItemWithTitle:@"Major" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Dorian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Phrygian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Lydian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Mixolydian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Aeolian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Locrian" action:NULL keyEquivalent:@""];
    
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Harmonic Minor" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Locrian #6" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Harmonic Major" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Spanish Phrygian" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Double Harmonic Major" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Lydian b3" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Diminished" action:NULL keyEquivalent:@""];
    [menu addItem:[NSMenuItem separatorItem]];
    
    // Need more modes here
    [menu addItemWithTitle:@"Melodic Minor" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Altered" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Half Diminished" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Lydian Dominant" action:NULL keyEquivalent:@""];
    [menu addItem:[NSMenuItem separatorItem]];
    
    [menu addItemWithTitle:@"Blues" action:NULL keyEquivalent:@""];
    [menu addItem:[NSMenuItem separatorItem]];

    [menu addItemWithTitle:@"Wholetone" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Pentatonic" action:NULL keyEquivalent:@""];
    [menu addItemWithTitle:@"Chromatic" action:NULL keyEquivalent:@""];

    [menu addItem:[NSMenuItem separatorItem]];
    
    return menu;
}
- (void)drawRect:(NSRect)dirtyRect
{
    //[[NSColor redColor] set];
    [[NSColor colorWithCalibratedHue:scale.hash() saturation:0.2 brightness:0.97 alpha:1.0] set];
    NSRectFillUsingOperation([self bounds], NSCompositeSourceOver);
    
    CGFloat h = [self bounds].size.height;
    CGFloat w = [self bounds].size.width;
    
    size_t nnotes = scale.gaps.size();
    CGFloat octaveheight = 140;
    CGFloat memberheight = octaveheight / (CGFloat)nnotes;
    
    CGFloat yoffset = 0.0;
    for (int i = 0; yoffset < [self bounds].size.height; i++) {
        
        int g = scale.gaps[i % nnotes];
        
        CGFloat submemberheight = memberheight / (CGFloat)g;
        for (int j = 1; j < g; j++) {
            [[NSColor colorWithCalibratedWhite:0.0 alpha:0.33] set];
            NSRectFillUsingOperation(NSMakeRect(0, round(yoffset + submemberheight * j), w, 1), NSCompositeSourceOver);
        }
        
        [[NSColor colorWithCalibratedWhite:0.0 alpha:1.0] set];
        NSRectFillUsingOperation(NSMakeRect(0, round(yoffset), w, 1), NSCompositeSourceOver);
        
        yoffset += memberheight;
    }
}

@end
