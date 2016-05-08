//
//  PCPrimitiveValueToken.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCToken.h"

@interface PCPrimitiveValueToken : PCToken

@property (nonatomic, strong) id value;

-(NSNumber*)getValue;

@end
