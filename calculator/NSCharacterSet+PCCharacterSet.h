//
//  NSCharacterSet+PCCharacterSet.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCharacterSet (PCCharacterSet)

+(NSCharacterSet*)floatNumberCharacterSet;
+(NSCharacterSet*)openGroupingSet;
+(NSCharacterSet*)closeGroupingSet;

@end
