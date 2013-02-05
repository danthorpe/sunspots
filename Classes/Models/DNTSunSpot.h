//
//  DNTSunSpot.h
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DNTSunSpotAnalyser.h"

typedef NS_OPTIONS(NSUInteger, DNTSunSpotRelativePositions) {
    DNTSunSpotRelativeSamePosition = 0,
    DNTSunSpotRelativeNorthPosition = 1 << 0, // 1
    DNTSunSpotRelativeEastPosition = 1 << 1, // 2
    DNTSunSpotRelativeSouthPosition = 1 << 2, // 4
    DNTSunSpotRelativeWestPosition = 1 << 3, // 8
};

@interface DNTSunSpot : NSObject

@property (nonatomic) CGPoint coordinate;
@property (nonatomic) DNTSunSpotAnalyserSize size;
@property (nonatomic) NSNumber *intensity;
@property (nonatomic) NSUInteger score;

- (id)initWithCoordinate:(CGPoint)coordinate inSize:(DNTSunSpotAnalyserSize)size intensity:(NSNumber *)intensity;

- (CGPoint)coordinateAtRelativePosition:(DNTSunSpotRelativePositions)position;

- (NSArray *)neighbourhoodCoordinates;

@end
