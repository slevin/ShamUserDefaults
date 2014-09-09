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

@property (strong, nonatomic) NSString *key;

@end

@implementation ShamUserDefaultsTests

- (void)setUp
{
    [super setUp];
    [SLShamUserDefaults mockStandardUserDefaults];
    _key = [[NSUUID UUID] UUIDString];
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
    [defaults setInteger:7 forKey:_key];
    NSInteger results = [defaults integerForKey:_key];
    XCTAssertEqual(results, 7, @"integer matches");
}

- (void)testBoolStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:_key];
    BOOL results = [defaults boolForKey:_key];
    XCTAssertEqual(results, YES, @"bool matches");
}

- (void)testFloatStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    CGFloat value = 3.14159;
    [defaults setFloat:value forKey:_key];
    CGFloat results = [defaults floatForKey:_key];
    XCTAssertEqual(value, results, @"float matches");
}

- (void)testObjectStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *value = [[NSObject alloc] init];
    [defaults setObject:value forKey:_key];
    NSObject *results = [defaults objectForKey:_key];
    XCTAssertEqualObjects(value, results, @"objects match");
}

// gotta test nil for object // what does it do with user defaults?
// probably better to test against real user defaults?
// or maybe should just make new instance instead of standard user defaults?

- (void)testStringStorage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = @"testString";
    [defaults setObject:value forKey:_key];
    NSString *results = [defaults stringForKey:_key];
    XCTAssertEqualObjects(value, results, @"string matches");
}

@end
