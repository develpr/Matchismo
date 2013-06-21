//
//  Card.m
//  Matchismo
//
//  Created by Kevin Mitchell on 6/19/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

@synthesize faceUp = _faceUp;
@synthesize unplayable = _unplayable;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for(Card *card in otherCards){
        if([self.contents isEqualToString:card.contents]){
            score++;
        }
    }

    return score;
}

@end
