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
        self.childTokens = @[].mutableCopy;
    }
    return self;
}
@end
