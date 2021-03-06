//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Kevin Mitchell on 7/2/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
         matchCardCount:(int)cardsToMatch;

- (void)flipCardAtIndex:(NSUInteger) index;
- (Card *)cardAtIndex:(NSUInteger) index;

@property (readonly, nonatomic) NSAttributedString *lastMessage;
@property (readonly, nonatomic) int score;
@property (nonatomic) int cardsToMatch;
@property (nonatomic) bool activeGame;
@end
