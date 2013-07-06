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

- (void) addSelectedAttributes:(NSDictionary *)attributes withContent:(NSMutableAttributedString *)content
{
    NSRange range = [[content string] rangeOfString:[content string]];
    [content setAttributes:attributes range:range];
}

- (NSMutableAttributedString *) attributedContents
{
    NSString *content = @"";
    
    for(int i = 0; i < self.number; i++)
    {
        content = [content stringByAppendingString: self.shape];
    }

    NSMutableAttributedString *attributedContents = [[NSMutableAttributedString alloc] initWithString: content];

    UIColor *cardColor = [self calculateCardColor];
    
    
    [self addSelectedAttributes: @{ NSForegroundColorAttributeName : cardColor,
                                    NSStrokeWidthAttributeName: [self calculateStroke],
                                    NSStrokeColorAttributeName: cardColor} withContent:attributedContents];
    
    return attributedContents;
}

- (UIColor *) calculateCardColor
{
    UIColor *cardColor = self.color;
    
    if(self.shading == 2)
    {
        cardColor = [self.color colorWithAlphaComponent:.3];
    }
    
    return cardColor;
}

- (NSNumber *) calculateStroke
{
    NSNumber *stroke = @0;
    
    if(self.shading == 3)
    {
        stroke = @8;
    }
    
    return stroke;
}


- (int) match:(NSArray *)otherCards
{
    int points = 0;
    
    NSString *previousShape = self.shape;
    NSInteger previousShade = self.shading;
    UIColor *previousColor = self.color;
    NSInteger previousNumber = self.number;
    
    bool sameShape = true;
    bool sameColor = true;
    bool sameNumber = true;
    bool sameShade = true;
    
    for(SetCard *otherCard in otherCards)
    {
        sameColor = [previousColor isEqual:otherCard.color] && sameColor;
        sameShape = [previousShape isEqualToString:otherCard.shape] && sameShape;
        sameNumber = (otherCard.number == previousNumber) && sameNumber;
        sameShade = (otherCard.shading == previousShade) && sameShade;
        previousColor = otherCard.color;
        previousNumber = otherCard.number;
        previousShape = otherCard.shape;
        previousShade = otherCard.shading;
    }
    
    bool differentShape = true;
    bool differentColor = true;
    bool differentNumber = true;
    bool differentShade = true;
    
    previousShape = self.shape;
    previousShade = self.shading;
    previousColor = self.color;
    previousNumber = self.number;
    
    for(SetCard *otherCard in otherCards)
    {
        differentColor = (![previousColor isEqual:otherCard.color]) && differentColor;
        differentShape = (![previousShape isEqualToString:otherCard.shape]) && differentShape;
        differentNumber = (!(otherCard.number == previousNumber)) && differentNumber;
        differentShade = (!(otherCard.shading == previousShade)) && differentShade;
        previousColor = otherCard.color;
        previousNumber = otherCard.number;
        previousShape = otherCard.shape;
        previousShade = otherCard.shading;
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

+ (NSArray *) validShapes
{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *) validColors
{
    return @[[UIColor redColor], [UIColor blackColor], [UIColor blueColor]];
}


/*
 *      SETTERS AND GETTERS
 */
- (void) setNumber:(NSUInteger)number
{
    if(number >= 1 && number <= [[self class] maxNumber])
        _number = number;
}

- (void) setShading:(NSUInteger)shading
{
    if(shading >= 1 && shading <= [[self class] maxShade])
        _shading = shading;
}

- (void) setColor:(UIColor *)color
{
    if([[[self class] validColors] containsObject:color])
        _color = color;
}

- (void) setShape:(NSString *)shape
{
    if([[[self class] validShapes] containsObject:shape])
        _shape = shape;
}


@end
