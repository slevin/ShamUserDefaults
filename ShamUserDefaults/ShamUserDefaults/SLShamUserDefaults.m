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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storage = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] integerValue];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
}

- (BOOL)boolForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] boolValue];
}

- (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
}

- (CGFloat)floatForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] floatValue];
}

- (void)setFloat:(float)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
}

- (id)objectForKey:(NSString *)defaultName
{
    return [self.storage objectForKey:defaultName];
}

- (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [self.storage setObject:value forKey:defaultName];
}

/*
 Registering Defaults
 – registerDefaults:
 Getting Default Values
 – arrayForKey:
 – dataForKey:
 – dictionaryForKey:
 – objectForKey:
 – stringArrayForKey:
 – stringForKey:
 – doubleForKey:
 – URLForKey:
 Setting Default Values
 – setObject:forKey:
 – setDouble:forKey:
 – setURL:forKey:
 Removing Defaults
 – removeObjectForKey:
 Maintaining Persistent Domains
 – synchronize
 – persistentDomainForName:
 – removePersistentDomainForName:
 – setPersistentDomain:forName:
 – persistentDomainNames Deprecated in iOS 7.0
 Accessing Managed Environment Keys
 – objectIsForcedForKey:
 – objectIsForcedForKey:inDomain:
 Managing the Search List
 – dictionaryRepresentation
 Maintaining Volatile Domains
 – removeVolatileDomainForName:
 – setVolatileDomain:forName:
 – volatileDomainForName:
 – volatileDomainNames
 Maintaining Suites
 – addSuiteNamed:
 – removeSuiteNamed:
 
 */

/* Done
 – integerForKey:
 – setInteger:forKey:
 – setBool:forKey:
 – setFloat:forKey:
 – boolForKey:
 – floatForKey:
 
 
 */
@end
