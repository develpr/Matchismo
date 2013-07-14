//
//  SetCardView.h
//  Matchismo
//
//  Created by Kevin Mitchell on 7/11/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic, weak) UIColor *color;
@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger number;
@property (nonatomic) NSUInteger shade;

@property (nonatomic) BOOL faceUp;

@end
