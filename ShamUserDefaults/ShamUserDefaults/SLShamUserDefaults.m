//
//  SLShamUserDefaults.m
//  ShamUserDefaults
//
//  Created by Sean Levin on 9/6/14.
//  Copyright (c) 2014 Sean Levin. All rights reserved.
//

#import "SLShamUserDefaults.h"

@interface SLShamUserDefaults ()

@property (strong, nonatomic) NSMutableDictionary *storage;

@end

@implementation SLShamUserDefaults

+ (void)load
{
    
}

+ (instancetype)sham_standardUserDefaults
{
    return nil;
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
