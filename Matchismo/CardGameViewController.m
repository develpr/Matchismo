//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin Mitchell on 6/19/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;

@end
    
@implementation CardGameViewController

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    int cardsToMatch = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] intValue];
    
    self.game.cardsToMatch = cardsToMatch;    
}


- (IBAction)dealGame:(UIButton *)sender {
    
    int cardsToMatch = [[self.gameMode titleForSegmentAtIndex:self.gameMode.selectedSegmentIndex] intValue];
    
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                             matchCardCount:cardsToMatch];
    self.flipCount = 0;
    [self updateUI];
}

- (CardMatchingGame *)game
{
    
    int cardsToMatch = [[self.gameMode titleForSegmentAtIndex:self.gameMode.selectedSegmentIndex] intValue];
    
    if(!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                             matchCardCount:cardsToMatch];
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"card.png"];
    
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        //Set the image background
        if(!card.isFaceUp)
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        else
            [cardButton setImage:nil forState:UIControlStateNormal];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    self.statusLabel.text = self.game.lastMessage;
    
    //Disable the game mode switch if the game is active
    if(self.game.activeGame)
    {
        self.gameMode.userInteractionEnabled = NO;
        self.gameMode.alpha = 0.3;
    }
    else
    {
        self.gameMode.userInteractionEnabled = YES;
        self.gameMode.alpha = 1;
    }
    
    
}

@end
