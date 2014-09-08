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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShamIsSubstituted
{
    [SLShamUserDefaults takeOver];
    id defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

@end
