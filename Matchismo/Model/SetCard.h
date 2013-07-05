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

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shading;
@property (strong, nonatomic) NSAttributedString *content;

+ (NSArray *)validShapes;
+ (NSUInteger)maxNumber;
+ (NSUInteger)maxShade;
+ (NSArray *)validColors;

@end
