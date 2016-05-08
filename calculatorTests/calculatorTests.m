//
//  calculatorTests.m
//  calculatorTests
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCParser.h"
#import "PCNumberToken.h"
#import "PCAddOperatorToken.h"

@interface calculatorTests : XCTestCase

@end

@implementation calculatorTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTokenizeSingleFloatNumber {
    NSString *mathString = @"33.456";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    PCNumberToken *resultToken = result.firstObject;
    
    XCTAssertEqual(result.count, 1);
    XCTAssertEqual([result.firstObject isKindOfClass:[PCNumberToken class]], YES);
    XCTAssertEqual(resultToken.value.floatValue, @(33.456).floatValue);
}

- (void)testTokenizeSimpleAddOperation {
    NSString *mathString = @"1+2";
    
    PCParser *parser = [[PCParser alloc] init];
    NSArray *result = [parser tokenizeString:mathString];
    
    XCTAssertEqual(result.count, 3);
    XCTAssertEqual([result[1] isKindOfClass:[PCAddOperatorToken class]], YES);
}

//- (void)testTokenizeSingleFloatNumber {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSString *mathString = @"33.456+123";
//    PCParser *parser = [[PCParser alloc] init];
//    NSArray *result = [parser tokenizeString:mathString];
//    XCTAssertEqual(result.count, 1);
//    XCTAssertEqual([result.firstObject isKindOfClass:[PCNumberToken class]], YES);
//}

//- (void)testMakeParenthesesFormFromString {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSString *mathString = @"3+2*6";
//    PCParser *parser = [[PCParser alloc] init];
//    NSString *result = [parser createForceParenthesesFormFromEvaluationString:mathString];
//    XCTAssertEqual(result, @"(3+(2*6))");
//}


//- (void)testExample {
//    // This is an example of a functional test case.
//    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    NSString *mathString = @"(3+2.9)*6";
//    PCParser *parser = [[PCParser alloc] init];
//    PCToken *token = [parser parse:mathString];
//    XCTAssertEqual([token getValue], 54);
//}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
