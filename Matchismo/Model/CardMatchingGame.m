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
@property (readwrite, nonatomic) NSString *lastMessage;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (NSString *)lastMessage
{
    if(!_lastMessage)
        _lastMessage = [[NSString alloc] init];
    
    return _lastMessage;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void) flipCardAtIndex:(NSUInteger)index
{
    //Reset the message to a empty NSString so we can check if it's been set yet
    self.lastMessage = @"";
    
    Card *card = [self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastMessage = [NSString stringWithFormat:@"Matched %@ with %@ for %d points!", card.contents, otherCard.contents, matchScore * MATCH_BONUS];
                    } else{
                        otherCard.faceUp = NO;
                        self.lastMessage = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!", card.contents, otherCard.contents, MISMATCH_PENALTY];
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            if(self.lastMessage.length < 1)
                self.lastMessage = @"-1 point for swapping a card!";
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }
            else{
                self = nil;
                break;
            }
        }
        
    }
    
    return self;
}

- (Card *) cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
