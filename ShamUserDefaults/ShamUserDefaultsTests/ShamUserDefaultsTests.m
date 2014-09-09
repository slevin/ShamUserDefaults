//
//  ShamUserDefaultsTests.m
//  ShamUserDefaultsTests
//
//  Created by Sean Levin on 9/4/14.
//  Copyright (c) 2014 Sean Levin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLShamUserDefaults.h"

@interface ShamUserDefaultsTests : XCTestCase

@end

@implementation ShamUserDefaultsTests

- (void)setUp
{
    [super setUp];
    [SLShamUserDefaults mockStandardUserDefaults];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShamIsSubstituted
{
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

- (void)testDuplicateMockingIsFine
{
    [SLShamUserDefaults mockStandardUserDefaults];
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

- (void)testUnmocking
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [NSUserDefaults class], @"standardUserDefaults should return original.");
}

- (void)testDuplicateUnmockingIsFine
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    [SLShamUserDefaults unmockStandardUserDefaults];
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [NSUserDefaults class], @"standardUserDefaults should return original.");
}

- (void)recmockingIsFine
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    [SLShamUserDefaults mockStandardUserDefaults];
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [ShamUserDefaultsTests class], @"standardUserDefaults should return sham.");
}

- (void)testIntegerStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:7 forKey:@"integerKey"];
    NSInteger results = [defaults integerForKey:@"integerKey"];
    XCTAssertEqual(results, 7, @"integer matches");
}

@end
