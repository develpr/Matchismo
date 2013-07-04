//
//  PlayingCard.m
//  Matchismo
//
//  Created by Kevin Mitchell on 6/20/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards lastObject];
        if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }else if(otherCard.rank == self.rank){
            score = 4;
        }
    } else {
        NSString *previousSuit = @"";
        int previousRank = 0;
        bool suitMatch = YES;
        bool rankMatch = YES;
        
        previousRank = self.rank;
        previousSuit = self.suit;

        for(PlayingCard *otherCard in otherCards)
        {
            suitMatch = (suitMatch && [previousSuit isEqualToString:otherCard.suit]);
            rankMatch = (rankMatch && (previousRank == otherCard.rank));
        }
        
        if(rankMatch)
            score = 12;
        else if(suitMatch)
            score = 4;
    }
    
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;    
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank] && rank > 0)
        _rank = rank;
}

@end
