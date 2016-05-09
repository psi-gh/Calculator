//
//  NSError+PCError.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "NSError+PCError.h"

@implementation NSError (PCError)

+(NSError*)buildErrorWithDescription:(NSString *)description code:(NSInteger)code
{
    NSString *domain = @"com.paulchelly.calculator.ErrorDomain";
    NSInteger errorCode = code;
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:description
                 forKey:NSLocalizedDescriptionKey];
    return [[NSError alloc] initWithDomain:domain
                                      code:errorCode
                                  userInfo:userInfo];
}

@end
