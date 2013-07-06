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
@property (weak, nonatomic) IBOutlet UILabel *flipCounter;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation SetGameViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipCounter.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (CardMatchingGame *) game
{
    if(!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[SetCardDeck alloc] init]
                                             matchCardCount:3];
    return _game;
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealGame:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                      usingDeck:[[SetCardDeck alloc] init]
                                 matchCardCount:3];
    [self updateUI];
}

- (void) updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:card.attributedContents forState:UIControlStateNormal];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        
        if(card.isUnplayable)
            cardButton.backgroundColor = [UIColor redColor];
        else if(card.isFaceUp)
            cardButton.backgroundColor = [UIColor blueColor];
        else
            cardButton.backgroundColor = [UIColor whiteColor];
        
        
        
    }
}


@end
