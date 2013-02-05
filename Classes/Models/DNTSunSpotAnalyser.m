//
//  DNTSunSpotAnalyser.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpotAnalyser.h"

inline DNTSunSpotAnalyserSize DNTSunSpotAnalyserSizeMake(NSUInteger width, NSUInteger height) {
    DNTSunSpotAnalyserSize size;
    size.width = width; size.height = height;
    return size;
}

@interface DNTSunSpotAnalyser ( /* Private */ )

@property (nonatomic, readwrite) DNTSunSpotAnalyserSize size;
@property (nonatomic, readwrite) NSArray *data;
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
    NSUInteger expected = [input[1] integerValue];
    NSUInteger N = [input[1] integerValue];
    NSArray *data = [input subarrayWithRange:NSMakeRange(2, input.count - 2)];
    self = [self initWithSize:DNTSunSpotAnalyserSizeMake(N, N) data:data];
    if (self) {
        self.expectedLengthOfAnswer = expected;
    }
    return self;
}

- (NSArray *)spotsAnalysedByOrder:(NSComparisonResult)order length:(NSUInteger)length {
    return nil;
}

- (id)analyse {
    return [[self spotsAnalysedByOrder:NSOrderedDescending length:self.expectedLengthOfAnswer] description];
}

@end
