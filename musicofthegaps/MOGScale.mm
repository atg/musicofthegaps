//
//  MOGScale.m
//  musicofthegaps
//
//  Created by Alex Gordon on 21/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MOGScale.h"

#define NOT_IMPLEMENTED @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"This method is not implemented" userInfo:nil]
#define INVALID_ARGUMENT @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Duh" userInfo:nil]

@implementation MOGScale

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

@synthesize name;
@synthesize gaps;

static NSMutableDictionary* scales;
+ (id)initialize {
    scales = [[NSMutableDictionary alloc] init];
    
    // Major modes
    [scales setObject:[self major] forKey:@"Major"];
    [scales setObject:[[self major] rotate:1] forKey:@"Dorian"];
    [scales setObject:[[self major] rotate:2] forKey:@"Phrygian"];
    [scales setObject:[[self major] rotate:3] forKey:@"Lydian"];
    [scales setObject:[[self major] rotate:4] forKey:@"Mixolydian"];
    [scales setObject:[[self major] rotate:5] forKey:@"Aeolian"];
    [scales setObject:[[self major] rotate:6] forKey:@"Locrian"];
    
    // Harmonic minor modes
    [scales setObject:[self harmonic] forKey:@"Harmonic Minor"];
    
    // Melodic minor modes
    [scales setObject:[self melodic] forKey:@"Melodic Minor"];
    
    // Pentatonic
    [scales setObject:[self pentatonic] forKey:@"Minor Pentatonic"];
    [scales setObject:[[self pentatonic] rotate:1] forKey:@"Major Pentatonic"];
    [scales setObject:[[self pentatonic] rotate:2] forKey:@"Pentatonic 3"];
    [scales setObject:[[self pentatonic] rotate:3] forKey:@"Pentatonic 4"];
    [scales setObject:[[self pentatonic] rotate:4] forKey:@"Pentatonic 5"];

    // Misc
    [scales setObject:[self chromatic] forKey:@"Chromatic"];
    [scales setObject:[self wholetone] forKey:@"Wholetone"];
}
+ (NSDictionary*)scales {
    return scales;
}
+ (NSArray*)names {
    return [scales allKeys];
}
+ (id)named:(NSString*)name {
    return [scales objectForKey:name];
}
+ (id)scaleWithPattern:(NSString*)pattern name:(NSString*)n {
    MOGScale* m = [[MOGScale alloc] init];
    m.name = n;
    
    const char* str = [pattern UTF8String];
    for (int i = 0; i < strlen(str); i++) {
        int gap = 0;
        if (str[i] == 'S')
            gap = 1;
        else if (str[i] == 'T')
            gap = 2;
        else if (str[i] == '3')
            gap = 3;
        else if (str[i] == '4')
            gap = 4;
        else
            INVALID_ARGUMENT;
        
        m.gaps.push_back(gap);
    }
    return m;
}

+ (id)major {
    return [[self class] scaleWithPattern:@"TTSTTTS" name:@"Major"];
}
+ (id)melodic {
    NOT_IMPLEMENTED;
//    return [[self class] scaleWithPattern:@"TTTTSTS" name:@"Melodic Minor"];
}
+ (id)harmonic {
    NOT_IMPLEMENTED;
}
+ (id)wholetone {
    return [[self class] scaleWithPattern:@"TTTTTT" name:@"Wholetone"];
}
+ (id)chromatic {
    return [[self class] scaleWithPattern:@"SSSSSSSSSSSS" name:@"Chromatic"];
}
+ (id)pentatonic {
    return [[self class] scaleWithPattern:@"SSSSSSSSSSSS" name:@"Pentatonic"];
}

- (id)copyWithZone:(NSZone *)zone {
    MOGScale* m = [[[self class] allocWithZone:zone] init];
    m.name = self.name;
    m.gaps = self.gaps;
    return m;
}
- (id)rotate:(int)amount {
    MOGScale* m = [self copy];
    std::rotate(m.gaps.begin(), m.gaps.begin() + i, m.gaps.end());
    return m;
}

- (unsigned)hash {
    unsigned hash, i;
    for(hash = i = 0; i < gaps.size(); ++i)
    {
        hash += gaps[i];
        hash += (hash << 10);
        hash ^= (hash >> 6);
    }
    hash += (hash << 3);
    hash ^= (hash >> 11);
    hash += (hash << 15);
    return hash;
}


@end
