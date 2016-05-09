//
//  PCEvaluationTreeNode.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCPrimitiveValueToken.h"
#import "PCOperatorToken.h"

@interface PCEvaluationTreeNode : NSObject

@property (nonatomic, strong) PCToken *token;
@property (nonatomic, strong) NSMutableArray *childNodes;

-(id)getResult;

@end
