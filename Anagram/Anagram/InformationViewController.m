//
//  InformationViewController.m
//  Anagram
//
//  Created by Edan Lichtenstein on 5/2/14.
//  Copyright (c) 2014 Edan Lichtenstein. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
- (IBAction)dismissInformationVCTapped:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *attributionLabel;

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

    [self buildDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) buildDisplay
{
    self.attributionLabel.text = @"Letter Sort Created by \nEdan Lichtenstein \nwww.ruckt.com";
    self.attributionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    self.attributionLabel.textAlignment = NSTextAlignmentCenter;
    
}


- (IBAction)dismissInformationVCTapped:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
