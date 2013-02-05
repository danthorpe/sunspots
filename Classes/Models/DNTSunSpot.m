//
//  DNTSunSpot.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpot.h"

@implementation DNTSunSpot

- (id)initWithCoordinate:(CGPoint)coordinate intensity:(NSNumber *)intensity {
    self = [super init];
    if (self) {
        self.coordinate = coordinate;
        self.intensity = intensity;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"(%d,%d score:%@)", (NSUInteger)self.coordinate.x, (NSUInteger)self.coordinate.y, self.intensity];
}

@end
