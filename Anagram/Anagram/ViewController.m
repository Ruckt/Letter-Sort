//
//  ViewController.m
//  Anagram
//
//  Created by Edan Lichtenstein on 3/11/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ViewController.h"
#import "DataStore.h"
//#import "WordList.h"

@interface ViewController ()

@property DataStore *dataStore;

@property (strong, nonatomic) NSMutableArray *potentialWords;
@property (weak, nonatomic) IBOutlet UITextField *letterInputs;
@property (weak, nonatomic) IBOutlet UITextView *listOfWords;
@property (strong, nonatomic) NSOperationQueue *queue;

- (IBAction)activateLetterSortButton:(UIButton *)sender;





@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [DataStore sharedDataStore];
    
    self.letterInputs.delegate = self;
    [self.letterInputs becomeFirstResponder];
    
    self.queue = [[NSOperationQueue alloc] init];
    //self.queue.maxConcurrentOperationCount=1;

}





#pragma mark User Input Areas

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self inputToWords];
    [self.letterInputs resignFirstResponder];
    return YES;
}

- (IBAction)activateLetterSortButton:(UIButton *)sender {
    [self inputToWords];
    [self.letterInputs resignFirstResponder];
}


#pragma mark Make it Work

-(void) inputToWords
{

    
    [self.queue addOperationWithBlock:^{
        NSMutableArray *characterInputReceived = [self turnInputIntoArray];
        self.potentialWords = [self recursiveLetterMixer:characterInputReceived];
        NSLog(@"All letter combinations: %@", self.potentialWords);
        [self findingPossibleWords];
    }];
}


-(NSMutableArray *) turnInputIntoArray
{
    NSMutableArray *characterInput = [[NSMutableArray alloc] init];
    NSString *inputFromUser = self.letterInputs.text;
    
    for (NSInteger i=0;i<[inputFromUser length];i++) {
        unichar character;
        character = [inputFromUser  characterAtIndex:i];
        
        NSString *letter = [NSString stringWithFormat:@"%c", character];
        [characterInput addObject:letter];
    }
    
    NSLog(@"Input Array: %@", characterInput);
    return characterInput;
 }


-(void)findingPossibleWords
{
    NSLog(@"Possible words: ");
    for (NSString *potentialWord in self.potentialWords)
    {
        if ([self.dataStore isDictionaryWord:potentialWord]) {
            NSLog(@"%@", potentialWord);
            [self writeWordToView:potentialWord];
        }
    }
}


-(void)writeWordToView: (NSString *) word
{
    NSMutableArray *realWords = [[NSMutableArray alloc] init];
    [realWords addObject:word];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.listOfWords.text = [realWords componentsJoinedByString:@"\n"];
    });
}

#pragma mark Permutation Generation Recursion


-(NSMutableArray *) recursiveLetterMixer: (NSMutableArray *) randomLetters
{
    
    if([randomLetters count] > 2)
    {
        NSMutableArray *arrayToReturn = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i<[randomLetters count]; i++)
        {
            // NSLog(@"At i = %d, buildingBlock = %@", i, randomLetters);
            
            NSMutableArray *buildingArray = [[NSMutableArray alloc] initWithArray:randomLetters copyItems:YES];
            //NSLog(@"At i = %d, buildingBlock = %@", i, tempArray);
            
            NSString *offBreak = [buildingArray objectAtIndex:i];
            [buildingArray removeObjectAtIndex:i];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            tempArray = [self recursiveLetterMixer:buildingArray];
            
            
            for (NSInteger j = 0; j<[tempArray count]; j++){
                //    NSLog(@"At j = %d, buildingArray = %@", j, buildingArray);
                
                NSString *tempString = [tempArray objectAtIndex:j];
                NSString *newString = [offBreak stringByAppendingString:tempString];
                
                if ([self.dataStore isDictionaryWord:newString]) {
                    NSLog(@"Yes to word: %@", newString);
                }
                [arrayToReturn insertObject:newString atIndex:j];
                //NSLog(@"At j= %d, offbreak = %@, arrayToReturn = %@", j, offBreak, arrayToReturn);
            }
            //  NSLog(@"Returning = %@", arrayToReturn);
            
        }
        //NSLog(@"Returning after while = %@", arrayToReturn);
        
        return arrayToReturn;
        
    }
    else if([randomLetters count] == 2) {
        //NSLog(@"The 2s");
        
        NSString *letter1 = [randomLetters objectAtIndex:0];
        NSString *letter2 = [randomLetters objectAtIndex:1];
        NSString *string1 = [letter1 stringByAppendingString:letter2];
        NSString *string2 = [letter2 stringByAppendingString:letter1];
        //[recurredBuildingBlock removeObject:buildingString];
        
        NSMutableArray *foundationArray = [[NSMutableArray alloc] init];
        [foundationArray addObject:string1];
        [foundationArray addObject:string2];
        if ([self.dataStore isDictionaryWord:string1]) {
            NSLog(@"Yes to word: %@", string1);
        }
        if ([self.dataStore isDictionaryWord:string2]) {
            NSLog(@"Yes to word: %@", string2);
        }
        
        return foundationArray;
    }
    else
    {
        return randomLetters;
    }
    
    return randomLetters;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
