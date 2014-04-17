//
//  WordList.h
//  Anagram
//
//  Created by Edan Lichtenstein on 4/15/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordList : NSObject

-(id)init;
-(instancetype) initWithNSSet: (NSSet *) wordSet;
-(BOOL)isDictionaryWord:(NSString*) word;

@property (strong, nonatomic) NSSet *wordList;

@end
