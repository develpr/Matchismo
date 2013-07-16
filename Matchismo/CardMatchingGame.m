//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/2/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (readwrite, nonatomic) NSAttributedString *lastMessage;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardMatchingGame


- (NSMutableArray *)cards
{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (NSAttributedString *)lastMessage
{
    if(!_lastMessage)
        _lastMessage = [[NSAttributedString alloc] init];
    
    return _lastMessage;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    //Reset the message to a empty NSString so we can check if it's been set yet
    self.lastMessage = [[NSAttributedString alloc] initWithString:@""];
    
    //If a card has been flipped, then it's an active game
    self.activeGame = YES;
    
    Card *card = [self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp)
        {
            //We have one playable card, the card that was just tapped
            int cardsFound = 1;
            
            //Need to store the other cards in an array
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            
            for(Card *otherCard in self.cards)
            {
                if(otherCard.isFaceUp && !otherCard.isUnplayable)
                {
                    cardsFound++;
                    [otherCards addObject:otherCard];
                }

            }

            if(cardsFound == 3)
            {
                int matchScore = [card match:otherCards];
                if(matchScore)
                {
                    card.unplayable = YES;
                    for(Card *otherCard in otherCards)
                        otherCard.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    
                    //todo: update with property text
                    self.lastMessage =  [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Matched for %d points!", matchScore * MATCH_BONUS]];
                } else{
                    for(Card *otherCard in otherCards)
                        otherCard.faceUp = NO;
                    
                    self.lastMessage = [[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"No Match! %d point penalty!", MISMATCH_PENALTY]];
                    self.score -= MISMATCH_PENALTY;
                }
            }
            
            if(self.lastMessage.length < 1)
                self.lastMessage = [[NSAttributedString alloc] initWithString:@"-1 point for swapping a card!"];
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        self.deck = deck;
        for(int i = 0; i < count; i++){
            Card *card = [self.deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }
            else{
                self = nil;
                break;
            }
        }
                
        //New games are not yet active
        self.activeGame = NO;
    }
        
    return self;
}

- (NSUInteger)cardsRemaining
{
    return [self.deck cardsInDeck];
}

- (NSUInteger)cardsInPlay
{
    return [self.cards count];
}

- (NSUInteger)playableCards
{
    NSUInteger playableCards = 0;
    for(Card *card in self.cards){
        if(!card.isUnplayable){
            playableCards++;
        }
    }
    return playableCards;
}


- (void) drawAdditionalCards:(NSUInteger)cardsToDraw
{
    cardsToDraw = MIN(cardsToDraw, [self cardsRemaining]);
    
    if(cardsToDraw == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No more cards"
                                                        message:@"All cards have been drawn from the deck."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    for(int i = 1; i <= cardsToDraw; i++){
        Card *card = [self.deck drawRandomCard];
        if(card){
            [self.cards addObject:card];
        }
    }
}

- (NSArray *) removeUnplayableCards
{
    NSMutableArray *unplayableIndexes = [[NSMutableArray alloc]init];
    
    NSArray *tempArray = [self.cards copy];
    for(Card *card in tempArray){
        if(card.isUnplayable){
            [unplayableIndexes addObject:[NSNumber numberWithInt:[tempArray indexOfObject:card]]];
            [self.cards removeObject:card];
        }
    }
    
    return unplayableIndexes;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
