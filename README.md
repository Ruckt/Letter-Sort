# 3/11/14

So you guys have been doing a lot of new frameworks and such...let's make sure your logic muscles are still strong!

Let's make the beginnings of a scrabble assist app.

The first hard problem to solve is an anagram solver. You're welcome to cheat...but what's the fun in that.

  1. Write a method that will generate a string of random characters.
  2. Write an anagram solver method that given any string will return an array of words possible from that string. Use only words of the same length, so no subsets.
  3. Step the game up a bit and allow for blanks in your string. Use `0` to signify a blank tile.
  4. Once you finish that...now solve the anagram for any sub string of the word passed in so you from a string such as `mefrt` you can make `farm` and `arm`.

## Checking if a word is a word

```objc
-(BOOL)isDictionaryWord:(NSString*) word {
    UITextChecker *checker = [[UITextChecker alloc] init];
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSString *currentLanguage = [currentLocale objectForKey:NSLocaleLanguageCode];
    NSRange searchRange = NSMakeRange(0, [word length]);
    NSRange misspelledRange = [checker rangeOfMisspelledWordInString:[word lowercaseString] range: searchRange startingAt:0 wrap:NO language: currentLanguage ];
    return misspelledRange.location == NSNotFound;
}
```
