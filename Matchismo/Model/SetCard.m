//
//  SetCard.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/4/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
    @property (readwrite, nonatomic) NSAttributedString *attributedContent;
@end

@implementation SetCard

- (NSAttributedString *) content
{
    NSString *content = @"";
    for(int i = 0; i < self.number; i++)
    {
        content = [content stringByAppendingString: self.shape];
    }
    
    NSAttributedString *attributedContent = [[NSAttributedString alloc] initWithString: content];
//    [attributedContent ]
    return attributedContent;
}


- (int) match:(NSArray *)otherCards
{
    int points = 0;
    
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
    return @[@"red", @"green", @"blue"];
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

- (void) setColor:(NSString *)color
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
