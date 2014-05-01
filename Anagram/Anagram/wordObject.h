//
//  wordObject.h
//  Anagram
//
//  Created by Edan Lichtenstein on 4/30/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface wordObject : NSObject

- (instancetype) initWithWord: (NSString *) word;

@property (strong, nonatomic) NSString *word;
@property NSInteger wordValue;

@end
