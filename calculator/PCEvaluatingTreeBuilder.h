//
//  PCEvaluatingTreeBuilder.h
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCEvaluationTreeNode.h"

@interface PCEvaluatingTreeBuilder : NSObject

+(PCEvaluationTreeNode *)generateEvaluationTreeFromGroupedTokens:(NSArray *)tokens;

@end
