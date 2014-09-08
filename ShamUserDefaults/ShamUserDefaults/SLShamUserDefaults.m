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

@interface SLShamUserDefaults ()

@property (strong, nonatomic) NSMutableDictionary *storage;

@end

@implementation SLShamUserDefaults

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sStandardShamUserDefaults = [[SLShamUserDefaults alloc] init];
    });
}

+ (instancetype)sham_standardUserDefaults
{
    return sStandardShamUserDefaults;
}

+ (void)takeOver
{

    Class userDefaultsClass = [NSUserDefaults class];
    Class shamUserDefaulsClass = [SLShamUserDefaults class];
    
    Method originalMethod = class_getClassMethod(userDefaultsClass, @selector(standardUserDefaults));
    Method newMethod = class_getClassMethod(shamUserDefaulsClass, @selector(sham_standardUserDefaults));
    method_exchangeImplementations(originalMethod, newMethod);
    
    /*
     Class dateClass = [NSDate class];
     
     // Let’s store the original timeIntervalSinceNow in a safe place
     IMP originalIMP = class_getMethodImplementation(dateClass, @selector(timeIntervalSinceNow));
     Method originalMethod = class_getInstanceMethod(dateClass, @selector(timeIntervalSinceNow));
     const char *typeEncoding = method_getTypeEncoding(originalMethod);
     BOOL result = class_addMethod(dateClass, @selector(delorean_unmockedTimeIntervalSinceNow), originalIMP, typeEncoding);
     NSAssert(result, @"Couldn't store the original timeIntervalSinceNow in a safe place");

     
     
     
     TUSwizzleClassMethods(dateClass,
     @selector(timeIntervalSinceReferenceDate),
     @selector(delorean_timeIntervalSinceReferenceDate));
     
     
    Method originalMethod = class_getClassMethod(cls, originalSel);
	Method newMethod = class_getClassMethod(cls, newSel);
	method_exchangeImplementations(originalMethod, newMethod);
     
     
     */
}

- (NSInteger)integerForKey:(NSString *)defaultName
{
    return [[self.storage objectForKey:defaultName] integerValue];
}

- (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    [self.storage setObject:@(value) forKey:defaultName];
}

/*
 Registering Defaults
 – registerDefaults:
 Getting Default Values
 – arrayForKey:
 – boolForKey:
 – dataForKey:
 – dictionaryForKey:
 – floatForKey:
 – integerForKey:
 – objectForKey:
 – stringArrayForKey:
 – stringForKey:
 – doubleForKey:
 – URLForKey:
 Setting Default Values
 – setBool:forKey:
 – setFloat:forKey:
 – setInteger:forKey:
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

@end
