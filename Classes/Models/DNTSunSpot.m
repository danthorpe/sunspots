//
//  DNTSunSpot.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpot.h"

@implementation DNTSunSpot

- (id)initWithCoordinate:(CGPoint)coordinate inSize:(DNTSunSpotAnalyserSize)size intensity:(NSNumber *)intensity {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.size = size;
        self.intensity = intensity;
    }
    return self;
}

- (CGPoint)coordinateAtRelativePosition:(DNTSunSpotRelativePositions)position {
    CGPoint p = CGPointMake(self.coordinate.x, self.coordinate.y);

    if ( ( self.coordinate.y > 0 ) && ((position & DNTSunSpotRelativeNorthPosition) > 0) ) {
        p.y -= 1;
    } else if ( ( self.coordinate.y < (self.size.height - 1) ) && (position & DNTSunSpotRelativeSouthPosition) > 0) {
        p.y += 1;
    }

    if ( ( self.coordinate.x > 0 ) && ((position & DNTSunSpotRelativeWestPosition) > 0)) {
        p.x -= 1;
    } else if ( ( self.coordinate.x < (self.size.width - 1) ) && (position & DNTSunSpotRelativeEastPosition) > 0) {
        p.x += 1;
    }

    return p;
}

- (NSSet *)neighbourhoodCoordinates {

    static NSArray *possibles = nil;
    if (!possibles) {
        possibles = @[ @(DNTSunSpotRelativeNorthPosition),
                       @(DNTSunSpotRelativeNorthPosition | DNTSunSpotRelativeEastPosition),
                       @(DNTSunSpotRelativeEastPosition),
                       @(DNTSunSpotRelativeSouthPosition | DNTSunSpotRelativeEastPosition),
                       @(DNTSunSpotRelativeSouthPosition),
                       @(DNTSunSpotRelativeSouthPosition | DNTSunSpotRelativeWestPosition),
                       @(DNTSunSpotRelativeWestPosition),
                       @(DNTSunSpotRelativeNorthPosition | DNTSunSpotRelativeWestPosition) ];
    }

    NSMutableSet *neighbourhood = [NSMutableSet setWithCapacity:8];

    CGPoint p;
    for ( NSNumber *position in possibles ) {

        p = [self coordinateAtRelativePosition:[position integerValue]];
//        NSLog(@"coord: %@, postion: %@, p: %@", NSStringFromCGPoint(self.coordinate), position, NSStringFromCGPoint(p));
        if ( !CGPointEqualToPoint(self.coordinate, p)) {
            [neighbourhood addObject:[NSValue valueWithCGPoint:p]];
        }
    }

    return neighbourhood;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d,%d score:%d)", (NSUInteger)self.coordinate.x, (NSUInteger)self.coordinate.y, self.score];
}

@end
