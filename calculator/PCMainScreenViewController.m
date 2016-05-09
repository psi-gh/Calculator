//
//  PCMainScreenViewController.m
//  calculator
//
//  Created by Pavel Ivanov on 09/05/16.
//  Copyright © 2016 Pavel Ivanov. All rights reserved.
//

#import "PCMainScreenViewController.h"
#import "PCCalculator.h"

@interface PCMainScreenViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) PCCalculator *calculator;

@end

@implementation PCMainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculator = [[PCCalculator alloc] init];
}

- (IBAction)calculateButton:(id)sender {
    NSError *error;
    NSNumber *result = [self.calculator evalString:self.inputTextField.text
                                             error:&error];
    
    if (!result) {
        self.resultLabel.text = @"Ошибка";
        if (error) {
            self.resultLabel.text = error.localizedDescription;
        }
        
        return;
    }
    
    self.resultLabel.text = result.stringValue;
}

@end
