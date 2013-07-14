//
//  SetCard.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/4/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@end

@implementation SetCard


- (int) match:(NSArray *)otherCards
{
    int points = 0;
    
    NSUInteger previousShape = self.shape;
    NSInteger previousShade = self.shade;
    UIColor *previousColor = self.color;
    NSInteger previousNumber = self.number;
    
    bool sameShape = true;
    bool sameColor = true;
    bool sameNumber = true;
    bool sameShade = true;
    
    for(SetCard *otherCard in otherCards)
    {
        sameColor = [previousColor isEqual:otherCard.color] && sameColor;
        sameShape = (otherCard.shape == previousShape) && sameShape;
        sameNumber = (otherCard.number == previousNumber) && sameNumber;
        sameShade = (otherCard.shade == previousShade) && sameShade;
        previousColor = otherCard.color;
        previousNumber = otherCard.number;
        previousShape = otherCard.shape;
        previousShade = otherCard.shade;
    }
    
    bool differentShape = true;
    bool differentColor = true;
    bool differentNumber = true;
    bool differentShade = true;
    
    previousShape = self.shape;
    previousShade = self.shade;
    previousColor = self.color;
    previousNumber = self.number;
    
    for(SetCard *otherCard in otherCards)
    {
        differentColor = (![previousColor isEqual:otherCard.color]) && differentColor;
        differentShape = (!(otherCard.shape == previousShape)) && differentShape;
        differentNumber = (!(otherCard.number == previousNumber)) && differentNumber;
        differentShade = (!(otherCard.shade == previousShade)) && differentShade;
        previousColor = otherCard.color;
        previousNumber = otherCard.number;
        previousShape = otherCard.shape;
        previousShade = otherCard.shade;
    }
    
    if((differentColor || previousColor) && (differentNumber || sameNumber) && (sameShape || differentShape) && (differentShape || sameShape))
        points = 12;
        
    return points;
}


+ (NSUInteger) maxNumber
{
    return 3;
}

+ (NSUInteger) maxShade
{
    return 3;
}

+ (NSUInteger) maxShape
{
    return 3;
}

+ (NSArray *) validColors
{
    return @[[UIColor redColor], [UIColor purpleColor], [UIColor greenColor]];
}


/*
 *      SETTERS AND GETTERS
 */
- (void) setNumber:(NSUInteger)number
{
    if(number >= 1 && number <= [[self class] maxNumber])
        _number = number;
}

- (void) setShade:(NSUInteger)shade
{
    if(shade >= 1 && shade <= [[self class] maxShade])
        _shade = shade;
}

- (void) setColor:(UIColor *)color
{
    if([[[self class] validColors] containsObject:color])
        _color = color;
}

- (void) setShape:(NSUInteger)shape
{
    if(shape >= 1 && shape <= [[self class] maxShape])
        _shape = shape;
}


@end
