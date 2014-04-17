//
//  DataStore.h
//  Anagram
//
//  Created by Edan Lichtenstein on 4/15/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

@property (strong, nonatomic) NSSet *wordList;

+ (DataStore *)sharedDataStore;
-(BOOL)isDictionaryWord:(NSString*) word;
-(void) parseWordListTXT;

@end
