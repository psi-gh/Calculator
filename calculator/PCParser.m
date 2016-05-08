//
//  PCParser.m
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCParser.h"
#import "PCToken.h"

@interface PCParser()

@property (nonatomic) NSArray *operators;
@property (nonatomic) NSArray *allowedOperandSymbols;

@end

@implementation PCParser

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operators = @[@"*", @"/", @"+", @"-"];
        self.allowedOperandSymbols = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @".", @"(", @")"];
    }
    
    return self;
}

-(NSString*)createForceParenthesesFormFromEvaluationString:(NSString*)mathString
{
	mathString = @"3+5*6";
    
    NSRange range;
    range.location = 0;
    range.length = mathString.length;
    for (NSString *operator in self.operators) {
        NSRange foundOperatorRange = [mathString rangeOfString:operator
                                                       options:NSCaseInsensitiveSearch
                                                         range:range];
    
//        if ([mathString substringWithRange:<#(NSRange)#>])
        // go left
        NSUInteger i = foundOperatorRange.location;
//        NSRange *leftSearch = foundOperatorRange;
//        leftSearch.location = i;
//        while ([mathString substringWithRange:foundOperatorRange]) {
//            <#statements#>
//        }
    }
    
    return mathString;
}
//
//-(id)calc {
//    NSString *expr = @"2+3";
//    [self calc1WithString:expr];
//}
//
//-(id)calc1WithString:(NSString *)expr {
//    lhs = [expr cutStringUntilOperator];
//    NSString *operator = [expr findStringFromArray:AllowedOperators]; // found +
//    rhs = [expr ]
//    
//}

-(void)parseForceParenthesesFormEvaluation:(NSString*)mathString
{
	
}

@end
