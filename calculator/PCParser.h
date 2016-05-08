//
//  PCParser.h
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCParser : NSObject

-(NSString*)createForceParenthesesFormFromEvaluationString:(NSString*)mathString;
-(void)parseForceParenthesesFormEvaluation:(NSString*)mathString;
-(NSArray*)tokenizeString:(NSString*)mathString;
@end
