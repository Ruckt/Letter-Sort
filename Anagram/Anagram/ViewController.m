//
//  ViewController.m
//  Anagram
//
//  Created by Edan Lichtenstein on 3/11/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "ViewController.h"
#import "DataStore.h"
#import <DKProgressHUD/DKProgressHUD.h>

@interface ViewController ()

@property DataStore *dataStore;

@property (strong, nonatomic) NSMutableArray *potentialWords;
@property (strong, nonatomic) NSMutableArray *realWords;
@property (weak, nonatomic) IBOutlet UITextField *letterInputs;
@property (weak, nonatomic) IBOutlet UITextView *listOfWords;
@property (strong, nonatomic) NSOperationQueue *queue;

- (IBAction)activateLetterSortButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UITableView *wordListTableView;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordListTableView.delegate = self;
    self.wordListTableView.dataSource = self;
    
    
    UIImage *logo = [UIImage imageNamed:@"LetterSortLogo.png"];
    _logoImageView = [[UIImageView alloc] initWithImage:logo];
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
    NSString *input = [self.letterInputs.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"Before %@", self.realWords);
    [self.realWords removeAllObjects];
    NSLog(@"After %@", self.realWords);

    
    if ([input length]<10) {
        
        [self.letterInputs setHidden:YES];
        [self startProgressHUD];
        
        self.realWords = [[NSMutableArray alloc] init];
        
        
        self.listOfWords.text = @"";
        [self.queue addOperationWithBlock:^{
            NSMutableArray *characterInputReceived = [self turnStringIntoCharacterArray:input];
            self.potentialWords = [self recursiveLetterMixer:characterInputReceived];
           // NSLog(@"All letter combinations: %@", self.potentialWords);
            [self stopProgressHUD];
            [self checkIfWordsMade];
            
        }];
    }
    else
    {
        self.listOfWords.text = @"Please visit github.com/Ruckt to submit memory efficient alogrithms for 10 letters or more";
        NSLog(@"Bigger than 10");
    }

   // [self.wordListTableView reloadData];


}



-(void) startProgressHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [DKProgressHUD showInView:self.view];
    });
   
    
}

-(void) stopProgressHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [DKProgressHUD hide];
        [self.letterInputs setHidden:NO];
        [self.wordListTableView reloadData];
    });


}

-(void) checkIfWordsMade
{
    if ([self.realWords count] == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.listOfWords.text = @"No words can be formed";
        });

    }
}

-(NSMutableArray *) turnStringIntoCharacterArray: (NSString *) string
{
    NSMutableArray *characterInput = [[NSMutableArray alloc] init];
    NSString *inputFromUser = [string lowercaseString];
    
  //  yourString stringByReplacingOccurrencesOfString:@" " withString:@""]
    
    
    for (NSInteger i=0;i<[inputFromUser length];i++) {
        unichar character;
        character = [inputFromUser  characterAtIndex:i];
        
        NSString *letter = [NSString stringWithFormat:@"%c", character];
        [characterInput addObject:letter];
    }
    
    NSLog(@"Input Array: %@", characterInput);
    return characterInput;
 }


//-(void)findingPossibleWords
//{
//    NSLog(@"Possible words: ");
//    for (NSString *potentialWord in self.potentialWords)
//    {
//        if ([self.dataStore isDictionaryWord:potentialWord]) {
//            NSLog(@"%@", potentialWord);
//            if (![self isWordPreviouslyGenerated:potentialWord]) {
//                [self writeWordToView:potentialWord];
//            }
//        }
//    }
//}

-(void)checkAndPrintIfWord: (NSString *) word
{
    if ([self.dataStore isDictionaryWord:word]) {
        if (![self isWordPreviouslyGenerated:word]) {
            NSLog(@"We got a word: %@", word);
            [self.realWords addObject:word];
            [self writeWordToView:word];
        }
    }
}

-(BOOL) isWordPreviouslyGenerated: (NSString *) word
{
    for (NSString *string in self.realWords)
    {
        if ([word isEqualToString: string]) {
            return YES;
        }
    }
    return NO;
}

-(void)writeWordToView: (NSString *) word
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.listOfWords.text = [self.listOfWords.text stringByAppendingString:word];
        self.listOfWords.text = [self.listOfWords.text stringByAppendingString:@"\n"];
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
                
                [self checkAndPrintIfWord:newString];
                [arrayToReturn insertObject:newString atIndex:j];
                //NSLog(@"At j= %d, offbreak = %@, arrayToReturn = %@", j, offBreak, arrayToReturn);
            }
            //  NSLog(@"Returning = %@", arrayToReturn);
            
        }
        //NSLog(@"Returning after while = %@", arrayToReturn);
        
        return arrayToReturn;
        
    }
    else if([randomLetters count] == 2) {
        //The 2-Letter foundation of each word
        
        NSString *letter1 = [randomLetters objectAtIndex:0];
        NSString *letter2 = [randomLetters objectAtIndex:1];
        NSString *string1 = [letter1 stringByAppendingString:letter2];
        NSString *string2 = [letter2 stringByAppendingString:letter1];
        //[recurredBuildingBlock removeObject:buildingString];
        
        NSMutableArray *foundationArray = [[NSMutableArray alloc] init];
        [foundationArray addObject:string1];
        [foundationArray addObject:string2];

       // [self checkAndPrintIfWord:string1];
       // [self checkAndPrintIfWord:string2];
        
        return foundationArray;
    }
    else
    {
        return randomLetters;
    }
    return randomLetters;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"Number of rows: %lu", (unsigned long)[self.realWords count]);
    return [self.realWords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text =[self.realWords objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
