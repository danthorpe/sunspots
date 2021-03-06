//
//  DNTSunSpotAnalyser.h
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    NSUInteger width;
    NSUInteger height;
} DNTSunSpotAnalyserSize;

@interface DNTSunSpotAnalyser : NSObject

@property (nonatomic, readonly) DNTSunSpotAnalyserSize size;
@property (nonatomic, readonly) NSArray *data;
@property (nonatomic, readonly) NSArray *spots;
@property (nonatomic, readonly) NSRange rangeOfScores;

/**
 * @abstract
 * Create a sun spot analyser of a given size with data.
 *
 * @param size, a DNTSunSpotAnalyserSize struct defining the width and height.
 * @param data, an NSArray instance of (width*height) NSNumbers organized
 * left to right and top to bottom.
 */
- (id)initWithSize:(DNTSunSpotAnalyserSize)size data:(NSArray *)data;

- (id)initWithInputData:(NSArray *)input;

/**
 * @abstract
 * Analyser the spots using the given order, and return
 * a sub array of the given length.
 */
- (NSArray *)spotsAnalysedByOrder:(NSComparisonResult)order length:(NSUInteger)length;

- (id)analyse;


@end

extern DNTSunSpotAnalyserSize DNTSunSpotAnalyserSizeMake(NSUInteger width, NSUInteger height);

/// Convenience functions to get the test data
extern NSArray *TestDataOne();
extern NSArray *TestDataTwo();