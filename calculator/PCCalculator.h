//
//  PCCalculator.h
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCalculator : NSObject

-(NSNumber *)evalString:(NSString*)evaluationString error:(NSError**)error;

@end
