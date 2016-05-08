//
//  NSCharacterSet+PCCharacterSet.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "NSCharacterSet+PCCharacterSet.h"

@implementation NSCharacterSet (PCCharacterSet)

+(NSCharacterSet*)floatNumberCharacterSet
{
    return [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
}

@end
