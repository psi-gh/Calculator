//
//  PCParser.h
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCToken.h"

@interface PCParser : NSObject

-(NSArray*)tokenizeString:(NSString*)mathString;

@end
