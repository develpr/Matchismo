//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/5/13.
//  Copyright (c) 2013 Kevin Mitchell. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if(self){
        for(NSUInteger shape = 1; shape <= [SetCard maxShape]; shape++){
            for(UIColor *color in [SetCard validColors]){
                for(NSUInteger number = 1; number <= [SetCard maxNumber]; number++){
                    for(NSUInteger shade = 1; shade <= [SetCard maxShade]; shade++){
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.color = color;
                        card.number = number;
                        card.shade = shade;
                        
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
        
    }
    
    return self;
}

@end
