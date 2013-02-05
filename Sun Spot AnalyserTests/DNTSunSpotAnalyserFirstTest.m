//
//  DNTSunSpotAnalyserFirstTest.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpotAnalyserTests.h"
#import "DNTSunSpotAnalyser.h"

@interface DNTSunSpotAnalyserFirstTest : DNTSunSpotAnalyserTests
@end

@implementation DNTSunSpotAnalyserFirstTest

- (void)setUp {
    [super setUp];

    self.input = @[ @(1), @(5),
                    @(5), @(3), @(1), @(2), @(0),
                    @(4), @(1), @(1), @(3), @(2),
                    @(2), @(3), @(2), @(4), @(3),
                    @(0), @(2), @(3), @(3), @(2),
                    @(1), @(0), @(2), @(4), @(3) ];
    self.analyser = [[DNTSunSpotAnalyser alloc] initWithInputData:self.input];
}

- (void)tearDown {
    self.input = nil;
    self.analyser = nil;
    [super tearDown];
}

- (void)testAnalyserInit {
    STAssertNotNil(self.analyser, @"The Analyser should not be nil");
    STAssertEquals(self.analyser.size.width, (NSUInteger)5, @"The width of the sunspot should be %d not %d", 5, self.analyser.size.width);
    STAssertEquals(self.analyser.size.height, (NSUInteger)5, @"The height of the sunspot should be %d not %d", 5, self.analyser.size.width);
    STAssertEqualObjects(self.analyser.data, [self.input subarrayWithRange:NSMakeRange(2, 25)], @"The analyser's data should equal the last 25 items in the input.");
}



- (void)testAnalyserAnswer {
    STAssertTrue([self.analyser respondsToSelector:@selector(spotsAnalysedByOrder:length:)], @"The analyser doesn't implement the method required to compute the answer");
    STAssertTrue([self.analyser respondsToSelector:@selector(analyse)], @"The analyser doesn't implement a convenience method to calculate the answer");

    // Execute the test
    NSString *answer = [self.analyser analyse];
    STAssertEqualObjects(answer, @"(3,3 score:26)", @"The analyser did not produce the correct output");

}

@end
