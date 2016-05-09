//
//  PCExtractor.h
//  calculator
//
//  Created by Pavel Ivanov on 08/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCToken.h"
#import "PCTokenCharacterBuffer.h"
#import "NSError+PCError.h"

@interface PCExtractor : NSObject

-(PCToken*)extractFromBuffer:(PCTokenCharacterBuffer*)buffer error:(NSError**)error;
-(BOOL)matchesPreconditionsInBuffer:(PCTokenCharacterBuffer*)buffer;

@end
