//
//  PCGrouper.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCEvaluationTreeNode.h"

@interface PCGrouper : NSObject

-(PCEvaluationTreeNode*)generateEvaluationTreeFromGroupedTokens:(NSArray *)tokens;
-(NSArray *)groupAllTokensInArray:(NSArray*)tokens;

@end
