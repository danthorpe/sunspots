//
//  DNTSunSpotAnalyserSecondTest.m
//  Sun Spot Analyser
//
//  Created by Daniel Thorpe on 05/02/2013.
//  Copyright (c) 2013 Daniel Thorpe. All rights reserved.
//

#import "DNTSunSpotAnalyserTests.h"
#import "DNTSunSpotAnalyser.h"

@interface DNTSunSpotAnalyserSecondTest : DNTSunSpotAnalyserTests
@end

@implementation DNTSunSpotAnalyserSecondTest

- (void)setUp {
    [super setUp];

    self.input = @[ @(3), @(4),
                    @(2), @(3), @(2), @(1),
                    @(4), @(4), @(2), @(0),
                    @(3), @(4), @(1), @(1),
                    @(2), @(3), @(4), @(4) ];
    self.analyser = [[DNTSunSpotAnalyser alloc] initWithInputData:self.input];
}

- (void)tearDown {
    self.input = nil;
    self.analyser = nil;
    [super tearDown];
}

- (void)testAnalyserInit {
    STAssertNotNil(self.analyser, @"The Analyser should not be nil");
    STAssertEquals(self.analyser.size.width, (NSUInteger)4, @"The width of the sunspot should be %d not %d", 5, self.analyser.size.width);
    STAssertEquals(self.analyser.size.height, (NSUInteger)4, @"The height of the sunspot should be %d not %d", 5, self.analyser.size.width);
    STAssertEqualObjects(self.analyser.data, [self.input subarrayWithRange:NSMakeRange(2, 16)], @"The analyser's data should equal the last 25 items in the input.");
}

- (void)testAnalyserAnswer {
    STAssertTrue([self.analyser respondsToSelector:@selector(spotsAnalysedByOrder:length:)], @"The analyser doesn't implement the method required to compute the answer");
    STAssertTrue([self.analyser respondsToSelector:@selector(analyse)], @"The analyser doesn't implement a convenience method to calculate the answer");

    // Execute the test
    NSArray *answer = [self.analyser analyse];
    STAssertEqualObjects([answer[0] description], @"(1,2 score:27)", @"The analyser did not produce the correct output");
    STAssertEqualObjects([answer[1] description], @"(1,1 score:25)", @"The analyser did not produce the correct output");
    STAssertEqualObjects([answer[2] description], @"(2,2 score:23)", @"The analyser did not produce the correct output");

}

@end
