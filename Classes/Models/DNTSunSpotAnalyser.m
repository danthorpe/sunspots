//
//  DNTSunSpotAnalyser.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpotAnalyser.h"
#import "DNTSunSpot.h"

inline DNTSunSpotAnalyserSize DNTSunSpotAnalyserSizeMake(NSUInteger width, NSUInteger height) {
    DNTSunSpotAnalyserSize size;
    size.width = width; size.height = height;
    return size;
}

@interface DNTSunSpotAnalyser ( /* Private */ )

@property (nonatomic, readwrite) DNTSunSpotAnalyserSize size;
@property (nonatomic, readwrite) NSArray *data;
@property (nonatomic) NSMutableArray *sunSpots;
@property (nonatomic) NSUInteger expectedLengthOfAnswer;

@end

@implementation DNTSunSpotAnalyser

- (id)initWithSize:(DNTSunSpotAnalyserSize)size data:(NSArray *)data {
    NSParameterAssert(data);
    NSAssert(data.count == (size.width * size.height), @"The length of the data array: %d does not correspond with the size argument: {%d,%d}", data.count, size.width, size.height);
    self = [super init];
    if (self) {
        self.size = size;
        self.data = data;
    }
    return self;
}

- (id)initWithInputData:(NSArray *)input {
    NSParameterAssert(input);
    NSAssert(input.count > 2, @"Data must have at least 3 values.");
    NSUInteger expected = [input[0] integerValue];
    NSUInteger N = [input[1] integerValue];
    NSArray *data = [input subarrayWithRange:NSMakeRange(2, input.count - 2)];
    self = [self initWithSize:DNTSunSpotAnalyserSizeMake(N, N) data:data];
    if (self) {
        self.expectedLengthOfAnswer = expected;
    }
    return self;
}

- (NSArray *)spotsAnalysedByOrder:(NSComparisonResult)order length:(NSUInteger)length {

    // Make sure we have some sun spot objects
    if ( !self.sunSpots ) {
        [self createSunSpots];
    }

    NSUInteger(^indexOfCoordinate)(CGPoint point) = ^(CGPoint point) {
        NSUInteger i = (point.y * self.size.width) + point.x;
        return i;
    };

    NSInteger i;

    // Iterate through them and calculate their scores
    for ( DNTSunSpot *sunSpot in self.sunSpots ) {

        // Calculate the score for the neighbood
        sunSpot.score = [sunSpot.intensity integerValue];

        NSArray *neighbourhood = [sunSpot neighbourhoodCoordinates];

        for ( NSValue *pointValue in neighbourhood ) {
            i = indexOfCoordinate( [pointValue CGPointValue] );
            sunSpot.score += [[self.sunSpots[i] intensity] integerValue];
        }
    }

    NSLog(@"sun spots: %@", self.sunSpots);

    // Sort the sun spots
    NSArray *sorted = [self.sunSpots sortedArrayUsingComparator:^NSComparisonResult(DNTSunSpot *spot1, DNTSunSpot *spot2) {
        if ( spot1.score == spot2.score ) {
            return NSOrderedSame;
        } else if ( spot1.score > spot2.score ) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];

    NSLog(@"sorted: %@", sorted);

    return [sorted subarrayWithRange:NSMakeRange(0, length)];
}

- (id)analyse {
    NSArray *answer = [self spotsAnalysedByOrder:NSOrderedDescending length:self.expectedLengthOfAnswer];
    if ( self.expectedLengthOfAnswer == 1 ) {
        return [answer[0] description];
    }
    return [answer description];
}

#pragma mark - Private

- (void)createSunSpots {
    self.sunSpots = [NSMutableArray arrayWithCapacity:self.data.count];

    NSUInteger i, x, y;
    DNTSunSpot *sunSpot = nil;
    for ( i = 0; i < self.data.count; i++ ) {
        x = i % self.size.width;
        y = i / self.size.width;
        sunSpot = [[DNTSunSpot alloc] initWithCoordinate:CGPointMake((CGFloat)x, (CGFloat)y) inSize:self.size intensity:self.data[i]];
        [self.sunSpots addObject:sunSpot];
    }
}

@end
