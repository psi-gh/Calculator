//
//  PCOperatorToken.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCToken.h"

@interface PCOperatorToken : PCToken

-(NSNumber*)getValueWithInputValues:(NSArray*)values;

@end
