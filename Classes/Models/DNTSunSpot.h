//
//  DNTSunSpot.h
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNTSunSpot : NSObject

@property (nonatomic) CGPoint coordinate;
@property (nonatomic) NSNumber *intensity;

- (id)initWithCoordinate:(CGPoint)coordinate intensity:(NSNumber *)intensity;

@end
