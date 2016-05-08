//
//  PCTokenCharacterBuffer.m
//  calculator
//
//  Created by Pavel Ivanov on 07/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCTokenCharacterBuffer.h"

@interface PCTokenCharacterBuffer()


@end

@implementation PCTokenCharacterBuffer

+(instancetype)initWithString:(NSString*)string
{
    PCTokenCharacterBuffer *buffer = [[PCTokenCharacterBuffer alloc] init];
    buffer -> _originalString = string;
    buffer.currentIndex = 0;
    return buffer;
}

-(NSString*)peekNextCharacters:(NSInteger)delta {
    if (delta < 0) {
        @throw @"Can't peek backward";
    }
    
    NSRange range;
    range.location = self.currentIndex;
    range.length = delta;
    return [self.originalString substringWithRange:range];
}

-(unichar)peekNextCharacter
{
    return [self.originalString characterAtIndex:self.currentIndex+1];
}

-(unichar)getCurrentCharacter
{
    return [self.originalString characterAtIndex:self.currentIndex];
}

-(void)consumeCharacters:(NSInteger)delta {
    if (delta < 0) {
        @throw @"Can't move carret backward";
    }
    
    self.currentIndex += delta;
}

-(void)resetTo:(NSUInteger)index
{
    self.currentIndex = index;
}

@end
