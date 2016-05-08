//
//  PCGrouper.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCGrouper.h"
#import "PCOperatorSet.h"
#import "PCOperatorToken.h"
#import "PCPrimitiveValueToken.h"
#import "PCGroupToken.h"

@interface PCGrouper()

@property (nonatomic, assign) NSUInteger endIndex;

@end

@implementation PCGrouper

-(NSArray *)groupAllTokensInArray:(NSArray*)tokens {
    NSMutableArray *resultTokens = [NSMutableArray arrayWithArray:tokens];

    for (PCToken *token in resultTokens) {
        if ([token isKindOfClass:[PCGroupToken class]]) {
            PCGroupToken *groupToken = (id)token;
            groupToken.groupedTokens = [self groupAllTokensInArray:groupToken.groupedTokens];
        }
    }
    
    NSMutableArray *arrayForNewGroup;
    
    do {
       // find operator with hightest precedence
        DDPrecedence maxPrecedence = -1;
        PCToken *tokenWithMaxPrecedence = nil;

        for (PCOperatorToken *token in resultTokens) {
            if ([token isKindOfClass:[PCOperatorToken class]]) {
                DDPrecedence precedenceOfToken = [[PCOperatorSet defaultOperatorSet] precedenceForOperation:token];
                if (precedenceOfToken > maxPrecedence) {
                    maxPrecedence = precedenceOfToken;
                    tokenWithMaxPrecedence = token;
                }
            }
        }
        
        if (maxPrecedence == -1) {
            break;
        }
        
        // put operator with left and right operand in group
        NSInteger indexOfToken = [resultTokens indexOfObject:tokenWithMaxPrecedence];
        arrayForNewGroup = [NSMutableArray arrayWithArray:@[resultTokens[indexOfToken-1],
                                                            resultTokens[indexOfToken],
                                                            resultTokens[indexOfToken+1]]];
        PCGroupToken *groupToken = [[PCGroupToken alloc] init];
        groupToken.groupedTokens = [NSArray arrayWithArray:arrayForNewGroup];
        [resultTokens insertObject:groupToken atIndex:indexOfToken];
        [resultTokens removeObjectsInArray:arrayForNewGroup];
        
    } while (1);
    
    return resultTokens;
}

-(PCEvaluationTreeNode*)generateEvaluationTreeFromGroupedTokens:(NSArray *)tokens
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

-(void)fillNode:(PCEvaluationTreeNode*)node WithTokens:(NSArray*)tokens {
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