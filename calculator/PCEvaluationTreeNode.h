//
//  PCEvaluationTreeNode.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCEvaluationTreeNode : NSObject

@property (nonatomic, strong) id token;
@property (nonatomic, strong) id parent;
@property (nonatomic, strong) NSMutableArray *childTokens;

-(id)getResult;

@end
