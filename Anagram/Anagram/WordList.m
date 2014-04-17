//
//  WordList.m
//  Anagram
//
//  Created by Edan Lichtenstein on 4/15/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "WordList.h"

@implementation WordList

-(instancetype) initWithNSSet: (NSSet *) wordSet
{
    self = [super init];
    if (self) {
        _wordList = wordSet;
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;

}


-(BOOL)isDictionaryWord:(NSString*) word
{
    if ([self.wordList containsObject:word]) {
        return YES;
    }
    else
    {
        return NO;
    }
    
    
}

@end
