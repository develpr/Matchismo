//
//  SetCard.h
//  Matchismo
//
//  Created by Kevin Mitchell on 7/4/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) UIColor *color;
@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shade;

+ (NSUInteger)maxShape;
+ (NSUInteger)maxNumber;
+ (NSUInteger)maxShade;
+ (NSArray *)validColors;  //UIColors 

@end
