//
//  SLShamUserDefaults.m
//  ShamUserDefaults
//
//  Created by Sean Levin on 9/6/14.
//  Copyright (c) 2014 Sean Levin. All rights reserved.
//

#import "SLShamUserDefaults.h"
#import <objc/runtime.h>

static SLShamUserDefaults *sStandardShamUserDefaults;
static BOOL sTakenOver;

@interface SLShamUserDefaults ()

@property (strong, nonatomic) NSMutableDictionary *storage;

@end

@implementation SLShamUserDefaults

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sTakenOver = NO;
        sStandardShamUserDefaults = [[SLShamUserDefaults alloc] init];
    });
}

+ (instancetype)sham_standardUserDefaults
{
    return sStandardShamUserDefaults;
}

+ (void)mockStandardUserDefaults
{
    @synchronized(self) {
        if (sTakenOver == NO) {
            [self swapStandardImplementations];
            sTakenOver = YES;
        }
    }
}

+ (void)unmockStandardUserDefaults
{
    @synchronized(self) {
        if (sTakenOver == YES) {
            [self swapStandardImplementations];
            sTakenOver = NO;
        }
    }
}

+ (void)swapStandardImplementations
{
    Class userDefaultsClass = [NSUserDefaults class];
    Class shamUserDefaulsClass = [SLShamUserDefaults class];
    
    Method originalMethod = class_getClassMethod(userDefaultsClass, @selector(standardUserDefaults));
    Method newMethod = class_getClassMethod(shamUserDefaulsClass, @selector(sham_standardUserDefaults));
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)clear
{
    _storage = [[NSMutableDictionary alloc] init];
}

+ (void)clearAll
{
    [sStandardShamUserDefaults clear];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark NSUserDefaults methods
- (BOOL)synchronize
{
    return YES;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] integerValue];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
    [self notify];
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] boolValue];
}

- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
    [self notify];
}

- (CGFloat)floatForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] floatValue];
}

- (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
    [self notify];
}

- (id)objectForKey:(NSString *)defaultName
{
    return [self.storage objectForKey:defaultName];
}

- (void)setObject:(id)value forKey:(NSString *)defaultName
{
    if (value == nil) {
        [self.storage removeObjectForKey:defaultName];
    } else {
        [self.storage setObject:value forKey:defaultName];
    }
    [self notify];
}

- (NSString *)stringForKey:(NSString *)defaultName
{
    NSString *results = [self objectForKey:defaultName];
    if ([results isKindOfClass:[NSString class]]) {
        return results;
    } else {
        return nil;
    }
}

- (void)setURL:(NSURL *)url forKey:(NSString *)defaultName
{
    [self.storage setObject:url forKey:defaultName];
    [self notify];
}

- (NSURL *)URLForKey:(NSString *)defaultName
{
    NSURL *results = [self objectForKey:defaultName];
    if ([results isKindOfClass:[NSURL class]]) {
        return results;
    } else {
        return nil;
    }
}

- (void)setDouble:(double)value forKey:(NSString *)defaultName
{
    [self.storage setObject:[NSNumber numberWithDouble:value] forKey:defaultName];
    [self notify];
}

- (double)doubleForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] doubleValue];
}

- (NSArray *)arrayForKey:(NSString *)defaultName
{
    NSArray *results = [self.storage objectForKey:defaultName];
    if ([results isKindOfClass:[NSArray class]]) {
        return results;
    } else {
        return nil;
    }
}

- (NSDictionary *)dictionaryForKey:(NSString *)defaultName
{
    NSDictionary *results = [self.storage objectForKey:defaultName];
    if ([results isKindOfClass:[NSDictionary class]]) {
        return results;
    } else {
        return nil;
    }
}

- (NSDictionary *)dictionaryRepresentation
{
    return [self.storage copy];
}

- (NSArray *)stringArrayForKey:(NSString *)defaultName
{
    NSArray *results = [self arrayForKey:defaultName];
    BOOL valid = YES;
    for (id item in results) {
        if ([item isKindOfClass:[NSString class]] == NO) {
            valid = NO;
            break;
        }
    }
    if (valid) {
        return results;
    } else {
        return nil;
    }
}

- (NSData *)dataForKey:(NSString *)defaultName
{
    NSData *results = [self.storage objectForKey:defaultName];
    if ([results isKindOfClass:[NSData class]]) {
        return results;
    } else {
        return nil;
    }
}

- (void)removeObjectForKey:(NSString *)defaultName
{
    [self setObject:nil forKey:defaultName];
}

- (void)notify
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NSUserDefaultsDidChangeNotification object:self];
}

#pragma mark Unhandled NSUserDefaults methods

// If you are calling these methods, from your code, you are likely doing something
// fancier than this mocking class can handle and you probably won't get the results
// you are looking for.

- (void)registerDefaults:(NSDictionary *)registrationDictionary
{
    NSAssert(NO, @"Not handled.");
}

- (void)addSuiteNamed:(NSString *)suiteName
{
    NSAssert(NO, @"Not handled.");
}

- (void)removeSuiteNamed:(NSString *)suiteName
{
    NSAssert(NO, @"Not handled.");
}

- (void)removeVolatileDomainForName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
}

- (void)setVolatileDomain:(NSDictionary *)domain forName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
}

- (NSDictionary *)volatileDomainForName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
    return nil;
}

- (NSArray *)volatileDomainNames
{
    NSAssert(NO, @"Not handled.");
    return nil;
}

- (BOOL)objectIsForcedForKey:(NSString *)key
{
    NSAssert(NO, @"Not handled.");
    return NO;
}

- (BOOL)objectIsForcedForKey:(NSString *)key inDomain:(NSString *)domain
{
    NSAssert(NO, @"Not handled.");
    return NO;
}

- (NSDictionary *)persistentDomainForName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
    return nil;
}

- (void)removePersistentDomainForName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
}

- (void)setPersistentDomain:(NSDictionary *)domain forName:(NSString *)domainName
{
    NSAssert(NO, @"Not handled.");
}

- (NSArray *)persistentDomainNames
{
    NSAssert(NO, @"Not handled.");
    return nil;
}

@end
