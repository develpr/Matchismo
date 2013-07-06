//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/4/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"


@interface SetGameViewController()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame * game;

@end

@implementation SetGameViewController

- (CardMatchingGame *) game
{
   
    if(!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                             matchCardCount:3];
    
    return _game;
}

- (IBAction)flipCard:(UIButton *)sender {
    [self updateUI];
    NSLog(@"TEST");
}


- (void) updateUI
{
    NSLog(@"HERE");
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:card.attributedContents forState:UIControlStateNormal];
    }
}


@end
