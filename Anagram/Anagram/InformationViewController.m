//
//  InformationViewController.m
//  Anagram
//
//  Created by Edan Lichtenstein on 5/2/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "InformationViewController.h"
#import "FontAwesomeKit/FAKIonIcons.h"
#import "UIColor+Colors.h"

@interface InformationViewController ()
@property (strong, nonatomic) IBOutlet UILabel *attributionLabel;
@property (strong, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
- (IBAction)dismissInformationVCTapped:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *dismissInformationVCButton;

@end

@implementation InformationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self buildDismissInformationVCButton];
    [self writeAboutLabel];
    [self writeInstructionsLabel];
    [self writeAttributionLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) writeAboutLabel
{
    NSString *letterSort = @"Letter Sort";
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:letterSort];
    NSInteger stringLength=[titleString length];
    UIColor *blue = [UIColor blueColorLetterSort];
    UIColor *purple = [UIColor purpleColorLetterSort];
    UIColor *red = [UIColor redColorLetterSort];
    UIColor *yellow = [UIColor yellowColorLetterSort];
    UIColor *green = [UIColor greenColorLetterSort];
    
    
    UIFont *font=[UIFont fontWithName:@"American Typewriter" size:45.0f];
    [titleString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    
    [titleString addAttribute:NSForegroundColorAttributeName value:blue range:NSMakeRange(0, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:purple range:NSMakeRange(1, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(2, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:yellow range:NSMakeRange(3, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:green range:NSMakeRange(4, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:blue range:NSMakeRange(5, 1)];
    
    [titleString addAttribute:NSForegroundColorAttributeName value:purple range:NSMakeRange(7, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(8, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:yellow range:NSMakeRange(9, 1)];
    [titleString addAttribute:NSForegroundColorAttributeName value:green range:NSMakeRange(10, 1)];
    
    self.aboutLabel.attributedText = titleString;

}

-(void) writeInstructionsLabel
{
    self.instructionsLabel.text = @" Tap on multi-colored lettering or\n return key after inputting letters.\n\n Two letter words not included.\n\n Words are sorted by board game\n tile values.\n\n Word list provided by Infochimps.\n\n Open source contributions on\n github.com/Ruckt/Letter-Sort.";
    self.instructionsLabel.font = [UIFont fontWithName:@"American Typewriter" size:17];
    self.instructionsLabel.textAlignment = NSTextAlignmentJustified;
    
    self.instructionsLabel.layer.borderWidth = 0.5;
    self.instructionsLabel.layer.borderColor = [UIColor blackColor].CGColor;
    self.instructionsLabel.layer.cornerRadius = 5.0f;
}
-(void) writeAttributionLabel
{
    self.attributionLabel.text = @"Letter Sort Created by \nEdan Lichtenstein \nwww.ruckt.com";
    self.attributionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:17];
    self.attributionLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void) buildDismissInformationVCButton
{
    FAKIonIcons *backIcon =[FAKIonIcons ios7ArrowThinDownIconWithSize:30];
    [backIcon addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColorLetterSort]];
    UIImage *dismissVCButtonImage = [backIcon imageWithSize:CGSizeMake(30, 30)];
    [self.dismissInformationVCButton setBackgroundImage:dismissVCButtonImage forState:UIControlStateNormal];
    self.dismissInformationVCButton.layer.borderWidth = 1.0;
    self.dismissInformationVCButton.layer.borderColor = [UIColor orangeColorLetterSort].CGColor;
    self.dismissInformationVCButton.layer.cornerRadius = 17.0f;

}

- (IBAction)dismissInformationVCTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
