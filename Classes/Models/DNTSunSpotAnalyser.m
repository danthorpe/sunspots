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
@property (nonatomic, readwrite) NSArray *spots;
@property (nonatomic, readwrite) NSRange rangeOfScores;
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
        [self createSunSpots];
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
    if ( !self.spots ) {
        [self createSunSpots];
    }

    NSUInteger(^indexOfCoordinate)(CGPoint point) = ^(CGPoint point) {
        NSUInteger i = (point.y * self.size.width) + point.x;
        return i;
    };

    NSInteger i;

    // Iterate through them and calculate their scores
    for ( DNTSunSpot *sunSpot in self.spots ) {

        // Calculate the score for the neighbood
        sunSpot.score = [sunSpot.intensity integerValue];

        NSArray *neighbourhood = [sunSpot neighbourhoodCoordinates];

        for ( NSValue *pointValue in neighbourhood ) {
            i = indexOfCoordinate( [pointValue CGPointValue] );
            sunSpot.score += [[self.spots[i] intensity] integerValue];
        }
    }

    // Sort the sun spots
    NSArray *sorted = [self.spots sortedArrayUsingComparator:^NSComparisonResult(DNTSunSpot *spot1, DNTSunSpot *spot2) {
        if ( spot1.score == spot2.score ) {
            return NSOrderedSame;
        } else if ( spot1.score > spot2.score ) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];

    NSUInteger minimum = [[sorted lastObject] score];
    NSUInteger maximum = [sorted[0] score];
    self.rangeOfScores = NSMakeRange(minimum, maximum - minimum);

    return [sorted subarrayWithRange:NSMakeRange(0, length)];
}

- (id)analyse {
    NSArray *answer = [self spotsAnalysedByOrder:NSOrderedDescending length:self.expectedLengthOfAnswer];
    if ( self.expectedLengthOfAnswer == 1 ) {
        return [answer[0] description];
    }
    return answer;
}

#pragma mark - Private

- (void)createSunSpots {
    NSMutableArray *spots = [NSMutableArray arrayWithCapacity:self.data.count];

    NSUInteger i, x, y;
    DNTSunSpot *sunSpot = nil;
    for ( i = 0; i < self.data.count; i++ ) {
        x = i % self.size.width;
        y = i / self.size.width;
        sunSpot = [[DNTSunSpot alloc] initWithCoordinate:CGPointMake((CGFloat)x, (CGFloat)y) inSize:self.size intensity:self.data[i]];
        [spots addObject:sunSpot];
    }

    self.spots = spots;
}

@end

/// Convenience functions to get the test data
NSArray *TestDataOne() {
    return @[ @(1), @(5),
              @(5), @(3), @(1), @(2), @(0),
              @(4), @(1), @(1), @(3), @(2),
              @(2), @(3), @(2), @(4), @(3),
              @(0), @(2), @(3), @(3), @(2),
              @(1), @(0), @(2), @(4), @(3) ];
}

NSArray *TestDataTwo() {
    return @[ @(3), @(4),
              @(2), @(3), @(2), @(1),
              @(4), @(4), @(2), @(0),
              @(3), @(4), @(1), @(1),
              @(2), @(3), @(4), @(4) ];
}
