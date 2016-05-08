//
//  PCEvaluationTreeNode.m
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCEvaluationTreeNode.h"

@implementation PCEvaluationTreeNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.childNodes = @[].mutableCopy;
    }
    return self;
}

-(id)getResult {
    if ([self.token isKindOfClass:[PCPrimitiveValueToken class]]) {
        PCPrimitiveValueToken *token = (id)self.token;
        return [token getValue];
    } else if ([self.token isKindOfClass:[PCOperatorToken class]]) {
        PCOperatorToken *token = (id)self.token;
        NSMutableArray *arrayOfValues = @[].mutableCopy;
        for (PCEvaluationTreeNode *childNode in self.childNodes) {
            [arrayOfValues addObject:[childNode getResult]];
        }
        
        return [token getValueWithInputValues:arrayOfValues];
    } else if (self.token == nil) {
        if (self.childNodes && self.childNodes.count) {
            PCEvaluationTreeNode *childSingleNode = self.childNodes.firstObject;
            return [childSingleNode getResult];
        }
    }
    
    return nil;
}

@end
