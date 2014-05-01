//
//  wordObject.m
//  Anagram
//
//  Created by Edan Lichtenstein on 4/30/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "wordObject.h"

@implementation wordObject

- (instancetype) initWithWord: (NSString *) word
{
    self = [super init];
    if (self) {
        _word = word;
        _wordValue = [self getWordValue:word];
    }
    return self;
}


-(NSInteger) getWordValue: (NSString *) word
{
    NSInteger value = 0;
    
    NSDictionary *gameValue = @{
                                @"a": [NSNumber numberWithInteger:1],
                                @"b": [NSNumber numberWithInteger:3],
                                @"c": [NSNumber numberWithInteger:3],
                                @"d": [NSNumber numberWithInteger:2],
                                @"e": [NSNumber numberWithInteger:1],
                                @"f": [NSNumber numberWithInteger:4],
                                @"g": [NSNumber numberWithInteger:2],
                                @"h": [NSNumber numberWithInteger:4],
                                @"i": [NSNumber numberWithInteger:1],
                                @"j": [NSNumber numberWithInteger:8],
                                @"k": [NSNumber numberWithInteger:5],
                                @"l": [NSNumber numberWithInteger:1],
                                @"m": [NSNumber numberWithInteger:3],
                                @"n": [NSNumber numberWithInteger:1],
                                @"o": [NSNumber numberWithInteger:1],
                                @"p": [NSNumber numberWithInteger:3],
                                @"q": [NSNumber numberWithInteger:10],
                                @"r": [NSNumber numberWithInteger:1],
                                @"s": [NSNumber numberWithInteger:1],
                                @"t": [NSNumber numberWithInteger:1],
                                @"u": [NSNumber numberWithInteger:1],
                                @"v": [NSNumber numberWithInteger:4],
                                @"w": [NSNumber numberWithInteger:4],
                                @"x": [NSNumber numberWithInteger:8],
                                @"y": [NSNumber numberWithInteger:4],
                                @"z": [NSNumber numberWithInteger:10]
                                };

    
    for (NSInteger i=0;i<[word length];i++) {
        unichar character;
        character = [word  characterAtIndex:i];
        
        NSString *letter = [NSString stringWithFormat:@"%c", character];
        
        value = value + [gameValue[letter] integerValue];
    }
    
    return value;
    

}



@end
