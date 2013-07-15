//
//  CardGameViewController.m
//  Matchismo
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University.
//  All rights reserved.
//

#import "CardGameViewController.h"
#import "GameResult.h"
#import "CardMatchingGame.h"

@interface CardGameViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) GameResult *gameResult;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

#pragma mark - Properties

- (GameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck { return nil; } // abstract

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}

#pragma mark - Updating the UI

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

#define pragma mark - Target/Action/Gestures

- (IBAction)deal
{
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self.cardCollectionView reloadData];
    [self updateUI];
}

- (void)drawAdditionalCards:(NSUInteger) cardsToDraw
{
    int difference = [self.cardCollectionView numberOfItemsInSection:0] - [self collectionView:self.cardCollectionView numberOfItemsInSection:0];
    NSLog(@"UpdateUI: %d", difference);
    
    NSUInteger preCount = [self.game cardsInPlay];
    
    [self.game drawAdditionalCards:cardsToDraw];
    
    NSUInteger postCount = [self.game cardsInPlay];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
    
    for(int i = preCount; i < postCount; i++){
        [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    
    NSIndexPath *scrollIndex = [indexPaths lastObject];

    [self.cardCollectionView insertItemsAtIndexPaths:indexPaths];
    
    [self updateUI];
    
    [self.cardCollectionView scrollToItemAtIndexPath:scrollIndex atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (void)removeUnplayableCards
{
    
        NSArray *indexes = [self.game removeUnplayableCards];
        NSMutableArray *indexPaths = [[NSMutableArray alloc]init];
    
        for(NSNumber *index in indexes){
            [indexPaths addObject:[NSIndexPath indexPathForItem:[index integerValue] inSection:0]];
        }
    
        [self.cardCollectionView deleteItemsAtIndexPaths:indexPaths];
        
    
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        
        
        [self removeUnplayableCards];
        
        [self updateUI];
        self.gameResult.score = self.game.score;
    }
}

@end
