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

@property (strong, nonatomic) NSMutableArray *realWords;

@property (weak, nonatomic) IBOutlet UITextField *letterInputs;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UITableView *wordListTableView;

@property (strong, nonatomic) NSMutableDictionary *wordDict;

- (IBAction)activateLetterSortButton:(UIButton *)sender;

@property (strong, nonatomic) NSOperationQueue *queue;



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




#pragma mark Make it Work

-(void) inputToWords
{
    NSString *input = [self.letterInputs.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self.realWords removeAllObjects];

    
    if ([input length]<10) {
        
        [self.letterInputs setHidden:YES];
        
        //[self startProgressHUD];
        [DKProgressHUD showInView:self.view];
        
        self.realWords = [[NSMutableArray alloc] init];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *characterInputReceived = [self turnStringIntoCharacterArray:input];
            
            [self recursiveLetterMixer:characterInputReceived];
            // NSLog(@"All letter combinations: %@", self.potentialWords);
            [self stopProgressHUD];
            
            [self checkIfWordsMade];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for (NSInteger i = 0; i < [self.realWords count]; i ++) {
                    
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
                    
                    [self.wordListTableView cellForRowAtIndexPath:ip];
                    
                }
                
                
            });
        });
        
        
    }
    else
    {
        [self showMessageWithTitle:@"Over Capacity" andMessage:@"Please visit github.com/Ruckt/Letter-Sort to submit memory efficient alogrithms for 10 letters or more."];
        NSLog(@"Bigger than 10");
    }

   //[self.wordListTableView reloadData];


}



-(void) checkIfWordsMade
{
    if ([self.realWords count] == 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMessageWithTitle:@"No Matching Words" andMessage:@"Please try again with different letters."];
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




-(void)checkAndPrintIfWord: (NSString *) word
{
    if ([self.dataStore isDictionaryWord:word]) {
        
        if (![self isWordPreviouslyGenerated:word]) {
            NSLog(@"We got a word: %@", word);
            [self.realWords addObject:word];
            //[self.wordListTableView reloadData];
            [self refreshScreen];
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

-(void)refreshScreen
{
    dispatch_async(dispatch_get_main_queue(), ^{
      
        [self.wordListTableView reloadData];
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
            
            NSString *offBreak = [buildingArray objectAtIndex:i];
            [buildingArray removeObjectAtIndex:i];
            
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            tempArray = [self recursiveLetterMixer:buildingArray];
            
            
            for (NSInteger j = 0; j<[tempArray count]; j++){
                
                NSString *tempString = [tempArray objectAtIndex:j];
                NSString *newString = [offBreak stringByAppendingString:tempString];
                
                [self checkAndPrintIfWord:newString];
                [arrayToReturn insertObject:newString atIndex:j];
                //NSLog(@"At j= %d, offbreak = %@, arrayToReturn = %@", j, offBreak, arrayToReturn);
            }
        }
        
        return arrayToReturn;
        
    }
    else if([randomLetters count] == 2) {
        //The 2-Letter foundation of each word
        
        NSString *letter1 = [randomLetters objectAtIndex:0];
        NSString *letter2 = [randomLetters objectAtIndex:1];
        NSString *string1 = [letter1 stringByAppendingString:letter2];
        NSString *string2 = [letter2 stringByAppendingString:letter1];
        
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


#pragma mark - UI Functions

-(void) showMessageWithTitle:(NSString *)title andMessage:(NSString *)messageText
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:title
                                                      message:messageText
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
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


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //[self refreshScreen];
    
    return [self.realWords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text =[self.realWords objectAtIndex:[indexPath row]];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}











@end
