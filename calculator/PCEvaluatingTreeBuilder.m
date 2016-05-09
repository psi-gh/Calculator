//
//  PCEvaluatingTreeBuilder.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCEvaluatingTreeBuilder.h"
#import "PCOperatorSet.h"
#import "PCOperatorToken.h"
#import "PCPrimitiveValueToken.h"
#import "PCGroupToken.h"

@implementation PCEvaluatingTreeBuilder

+(PCEvaluationTreeNode*)generateEvaluationTreeFromGroupedTokens:(NSArray *)tokens
{
    PCEvaluationTreeNode *node = nil;
    for (PCToken *token in tokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            node = [[PCEvaluationTreeNode alloc] init];
            [self fillNode:node WithTokens:((PCGroupToken*)token).groupedTokens];
        }
    }
    
    return node;
}

+(void)fillNode:(PCEvaluationTreeNode*)node WithTokens:(NSArray*)tokens
{
    for (PCToken *token in tokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCEvaluationTreeNode *complexNode = [[PCEvaluationTreeNode alloc] init];
            [self fillNode:complexNode WithTokens:((PCGroupToken*)token).groupedTokens];
            [node.childNodes addObject:complexNode];
        } else if ([token isKindOfClass:[PCPrimitiveValueToken class]]) {
            PCEvaluationTreeNode *leafNode = [[PCEvaluationTreeNode alloc] init];
            leafNode.token = token;
            [node.childNodes addObject:leafNode];
        } else if ([token isKindOfClass:[PCOperatorToken class]]) {
            node.token = token;
        }
    }
}

@end
