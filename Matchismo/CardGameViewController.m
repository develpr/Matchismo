//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Kevin Mitchell on 6/19/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (PlayingCardDeck *)deck
{
    if(!_deck)
        _deck = [[PlayingCardDeck alloc] init];
        
    return _deck;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    
    PlayingCard *card = (PlayingCard *)[self.deck drawRandomCard];
    
    [sender setTitle:card.contents forState:UIControlStateSelected];
    
    self.flipCount++;
}


@end
