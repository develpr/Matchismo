//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/13/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardCollectionViewCell.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController () <UICollectionViewDataSource>
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet SetCardView *selectedCard1;
@property (weak, nonatomic) IBOutlet SetCardView *selectedCard2;

@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                          usingDeck:[self createDeck]];
    
    return _game;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)drawThreeCards {
    [self drawAdditionalCards:3];
}

- (NSUInteger)startingCardCount
{
    return 12;
}

#pragma mark - UICollectionViewDataSource

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    NSArray *flippedCards = [self.game flippedCards];
    [self clearDisplayCards];
    int count = 1;
    for(SetCard *card in flippedCards){
        if(count == 1){
            self.selectedCard1.number = card.number;
            self.selectedCard1.shape = card.shape;
            self.selectedCard1.shade = card.shade;
            self.selectedCard1.color = card.color;
        }else{
            self.selectedCard2.number = card.number;
            self.selectedCard2.shape = card.shape;
            self.selectedCard2.shade = card.shade;
            self.selectedCard2.color = card.color;
        }
        count++;
    }
    
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            
            setCardView.number = setCard.number;
            setCardView.color = setCard.color;
            setCardView.shade = setCard.shade;
            setCardView.shape = setCard.shape;
            
            setCardView.faceUp = setCard.isFaceUp;
            
            if(setCardView.faceUp){
                self.selectedCard1.number = setCard.number;
                self.selectedCard1.shape = setCard.shape;
                self.selectedCard1.shade = setCard.shade;
                self.selectedCard1.color = setCard.color;
            }
        }
    }
}



- (void)clearDisplayCards
{
        
    self.selectedCard1.number = nil;
    self.selectedCard1.shape = nil;
    self.selectedCard1.shade = nil;
    self.selectedCard1.color = nil;
    self.selectedCard2.color = nil;
    self.selectedCard2.shape = nil;
    self.selectedCard2.shade = nil;
    self.selectedCard2.number = nil;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    NSUInteger itemCount = [self.game cardsInPlay];
    
    return itemCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

@end
