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
@property (strong, nonatomic) NSUserDefaults *defaults;

@end

@implementation ShamUserDefaultsTests

- (void)setUp
{
    [super setUp];
    _key = [[NSUUID UUID] UUIDString];
    [SLShamUserDefaults mockStandardUserDefaults];
    _defaults = [NSUserDefaults standardUserDefaults];
}

- (void)tearDown
{
    [SLShamUserDefaults clearAll];
    [super tearDown];
}

- (void)testShamIsSubstituted
{
    XCTAssertEqualObjects([_defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

- (void)testDuplicateMockingIsFine
{
    [SLShamUserDefaults mockStandardUserDefaults];
    _defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([_defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

- (void)testUnmocking
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    _defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([_defaults class], [NSUserDefaults class], @"standardUserDefaults should return original.");
}

- (void)testDuplicateUnmockingIsFine
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    [SLShamUserDefaults unmockStandardUserDefaults];
    _defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([_defaults class], [NSUserDefaults class], @"standardUserDefaults should return original.");
}

- (void)testRemockingIsFine
{
    [SLShamUserDefaults unmockStandardUserDefaults];
    [SLShamUserDefaults mockStandardUserDefaults];
    _defaults = [NSUserDefaults standardUserDefaults];
    XCTAssertEqualObjects([_defaults class], [SLShamUserDefaults class], @"standardUserDefaults should return sham.");
}

- (void)testIntegerStorage
{
    [_defaults setInteger:7 forKey:_key];
    NSInteger results = [_defaults integerForKey:_key];
    XCTAssertEqual(results, 7, @"integer matches");
}

- (void)testBoolStorage
{
    [_defaults setBool:YES forKey:_key];
    BOOL results = [_defaults boolForKey:_key];
    XCTAssertEqual(results, YES, @"bool matches");
}

- (void)testFloatStorage
{
    CGFloat value = 3.14159;
    [_defaults setFloat:value forKey:_key];
    CGFloat results = [_defaults floatForKey:_key];
    XCTAssertEqual(value, results, @"float matches");
}

- (void)testObjectStorage
{
    NSObject *value = [[NSObject alloc] init];
    [_defaults setObject:value forKey:_key];
    NSObject *results = [_defaults objectForKey:_key];
    XCTAssertEqualObjects(value, results, @"objects match");
}

- (void)testNilObject
{
    [_defaults setObject:@"abcd" forKey:_key];
    [_defaults setObject:nil forKey:_key];
    id it = [_defaults objectForKey:_key];
    XCTAssertNil(it, @"nil right?");
}

- (void)testStringStorage
{
    NSString *value = @"testString";
    [_defaults setObject:value forKey:_key];
    NSString *results = [_defaults stringForKey:_key];
    XCTAssertEqualObjects(value, results, @"string matches");
}

- (void)testInvalidStringStorage
{
    id value = [[NSObject alloc] init];
    [_defaults setObject:value forKey:_key];
    id results = [_defaults stringForKey:_key];
    XCTAssertNil(results, @"object not a string");
}

- (void)testURLStorage
{
    NSURL *value = [[NSURL alloc] initWithString:@"http://www.yahoo.com"];
    [_defaults setURL:value forKey:_key];
    NSURL *results = [_defaults URLForKey:_key];
    XCTAssertEqualObjects(value, results, @"url matches");
}

- (void)testDoubleStorage
{
    double value = 1.2345;
    [_defaults setDouble:value forKey:_key];
    double results = [_defaults doubleForKey:_key];
    XCTAssertEqual(value, results, @"doubles match");
}

- (void)testArrayStorage
{
    NSArray *value = @[@1];
    [_defaults setObject:value forKey:_key];
    NSArray *results = [_defaults arrayForKey:_key];
    XCTAssertEqualObjects(value, results, @"arrays match");
}

- (void)testInvalidArray
{
    id value = [[NSObject alloc] init];
    [_defaults setObject:value forKey:_key];
    NSArray *results = [_defaults arrayForKey:_key];
    XCTAssertNil(results, @"object not array");
}

- (void)testDictionaryStorage
{
    NSDictionary *value = @{@"key":@"value"};
    [_defaults setObject:value forKey:_key];
    NSDictionary *results = [_defaults dictionaryForKey:_key];
    XCTAssertEqualObjects(value, results, @"dictionaries match");
}

- (void)testInvalidDictionary
{
    id value = [[NSObject alloc] init];
    [_defaults setObject:value forKey:_key];
    NSDictionary *results = [_defaults dictionaryForKey:_key];
    XCTAssertNil(results, @"object not array");
}

- (void)testDictionaryRepresentation
{
    [_defaults setObject:@"abc" forKey:@"123"];
    NSDictionary *rep = [_defaults dictionaryRepresentation];
    XCTAssertEqualObjects(rep, @{@"123":@"abc"}, @"representation is dictionary");
}

- (void)testStringArrayStorage
{
    NSArray *value = @[@123, @"abc"];
    [_defaults setObject:value forKey:_key];
    NSArray *results = [_defaults stringArrayForKey:_key];
    XCTAssertNil(results, @"not valid string array");
}

- (void)testDataStorage
{
    NSData *value = [@"string" dataUsingEncoding:NSUnicodeStringEncoding];
    [_defaults setObject:value forKey:_key];
    NSData *results = [_defaults dataForKey:_key];
    XCTAssertEqualObjects(value, results, @"data match");
}

- (void)testInvalidData
{
    id value = [[NSObject alloc] init];
    [_defaults setObject:value forKey:_key];
    NSData *results = [_defaults dataForKey:_key];
    XCTAssertNil(results, @"invalid data");
}

- (void)testRemoval
{
    NSString *value = @"string";
    [_defaults setObject:value forKey:_key];
    [_defaults removeObjectForKey:_key];
    NSString *results = [_defaults objectForKey:_key];
    XCTAssertNil(results, @"object removed");
}
@end
