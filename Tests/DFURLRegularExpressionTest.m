//
//  DFURLRegularExpressionTest.m
//  DFURLRegularExpression
//
//  Created by David E. Wheeler on 12/16/10.
//  Copyright 2010 Kineticode, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "DFURLRegularExpression.h"

@interface DFURLRegularExpressionTest : SenTestCase;

@end

@implementation DFURLRegularExpressionTest

- (void)testRegexNotNil {
    STAssertNotNil([DFURLRegularExpression URLRegex], @"URLRegex should not be nil");
    STAssertNotNil([DFURLRegularExpression webURLRegex], @"WebURLRegex should not be nil");
}

- (void)testIsRegex {
    STAssertTrue([[DFURLRegularExpression URLRegex] isKindOfClass:NSRegularExpression.class], @"URLRegex should be a regex");
    STAssertTrue([[DFURLRegularExpression webURLRegex] isKindOfClass:NSRegularExpression.class], @"webURLRegex should be a regex");
}

- (void) regex:(NSRegularExpression *)regex matches:(NSString *)file {
    NSString *data = [NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]]pathForResource:file ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [data componentsSeparatedByCharactersInSet:
                      [NSCharacterSet newlineCharacterSet]];
    for (NSString *line in lines) {
        STAssertEquals(
            (int)[regex numberOfMatchesInString:line options:0 range:NSMakeRange(0, line.length)], 1,
            [NSString stringWithFormat:@"Should match %@", line]
        );
    }
}

- (void) regex:(NSRegularExpression *)regex noMatch:(NSString *)file {
    NSString *data = [NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]]pathForResource:file ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [data componentsSeparatedByCharactersInSet:
                      [NSCharacterSet newlineCharacterSet]];
    for (NSString *line in lines) {
        STAssertEquals(
            (int)[regex numberOfMatchesInString:line options:0 range:NSMakeRange(0, line.length)], 0,
            [NSString stringWithFormat:@"Should not match %@", line]
        );
    }
}

- (void) regex:(NSRegularExpression *)regex badMatch:(NSString *)file {
    NSString *data = [NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]]pathForResource:file ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [data componentsSeparatedByCharactersInSet:
                      [NSCharacterSet newlineCharacterSet]];
    for (NSString *line in lines) {
        NSTextCheckingResult *res = [regex firstMatchInString:line options:0 range:(NSRange)NSMakeRange(0, line.length)];
        NSString *substring = [line substringWithRange:res.range];
        STAssertFalse(
            [substring isEqual:line],
            [NSString stringWithFormat:@"@% should not equal %@", substring, line]
        );
    }
}

- (void)testURLRegex {
    [self regex:[DFURLRegularExpression URLRegex] matches:@"match_urls"];
}

- (void)testURLRegexNoMatch {
    [self regex:[DFURLRegularExpression URLRegex] noMatch:@"no_match_urls"];
}

- (void)testURLRegexBadMatch {
    [self regex:[DFURLRegularExpression URLRegex] badMatch:@"bad_match_urls"];
}

- (void)testWebURLRegex {
    [self regex:[DFURLRegularExpression webURLRegex] matches:@"web_urls"];
}

- (void)testWebURLRegexNoMatch {
    [self regex:[DFURLRegularExpression webURLRegex] noMatch:@"no_match_urls"];
}

- (void)testWebURLRegexBadMatch {
    [self regex:[DFURLRegularExpression webURLRegex] badMatch:@"bad_match_urls"];
}


@end
