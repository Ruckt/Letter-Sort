//
//  ViewController.h
//  Anagram
//
//  Created by Edan Lichtenstein on 3/11/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

-(NSString *) randomCharacterString: (NSInteger *) size;
-(BOOL)isDictionaryWord:(NSString*) word;

@end
