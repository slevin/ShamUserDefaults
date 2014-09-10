//
//  SLShamUserDefaults.h
//  ShamUserDefaults
//
//  Created by Sean Levin on 9/6/14.
//  Copyright (c) 2014 Sean Levin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLShamUserDefaults : NSUserDefaults

+ (void)mockStandardUserDefaults;
+ (void)unmockStandardUserDefaults;
+ (void)clearAll;

@end
