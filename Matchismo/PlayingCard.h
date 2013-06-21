//
//  PlayingCard.h
//  Matchismo
//
//  Created by Kevin Mitchell on 6/20/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
