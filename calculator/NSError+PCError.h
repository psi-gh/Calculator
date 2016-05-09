//
//  NSError+PCError.h
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (PCError)

+(NSError*)buildErrorWithDescription:(NSString *)description code:(NSInteger)code;

@end
