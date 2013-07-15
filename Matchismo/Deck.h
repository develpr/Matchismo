//
//  Deck.h
//  Matchismo
//
//  Created by Kevin Mitchell on 6/20/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;
- (NSUInteger)cardsInDeck;

@end
