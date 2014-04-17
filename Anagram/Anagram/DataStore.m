//
//  DataStore.m
//  Anagram
//
//  Created by Edan Lichtenstein on 4/15/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "DataStore.h"
#import "WordList.h"

@implementation DataStore


+ (DataStore *)sharedDataStore {
    static DataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[DataStore alloc] init];
    });
    
    return _sharedDataStore;
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

-(void) parseWordListTXT
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"word_list" ofType:@"txt"];
    NSString *contents = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:filePath] encoding:NSUTF8StringEncoding error:nil];
    
    //NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSArray *contentsOfString =[contents componentsSeparatedByString:@"\n"];
    
    NSMutableArray *individualWords = [[NSMutableArray alloc] init];
    
    for (NSString *wordPlus in contentsOfString) {
        if ([wordPlus length] > 0) {
        NSString *newString = [wordPlus substringToIndex:[wordPlus length]-1];
        //NSString *stringWithoutNewLine = [wordPlus stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //NSString *yourString = [wordPlus stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        [individualWords addObject:newString];
        }
    }
    
        
    
    self.wordList = [[NSSet alloc] initWithArray:individualWords];
        
    NSLog(@"%@", self.wordList);
    NSLog(@"finished");
    
}


@end
