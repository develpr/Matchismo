//
//  SetCardView.m
//  Matchismo
//
//  Created by Kevin Mitchell on 7/11/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define CORNER_RADIUS 12.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

- (void)setup
{
    // do initialization here
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CORNER_RADIUS];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    self.color = [UIColor redColor];
    self.shape = @"diamdond";
    self.number = 2;
    self.shade = 1;
    
    for(UIBezierPath *shape in [self getShapes]){
        [shape stroke];
    }

}

- (NSArray *)getShapes
{
    NSMutableArray *shapes = [[NSMutableArray alloc] init];
    
    CGFloat shapeWidth = self.bounds.size.width/5.9;
    CGFloat shapeHeight = self.bounds.size.height/1.9;

    CGFloat currentXPosition = CGRectGetMidX(self.bounds) -(self.number * shapeWidth * .6);
    
    for(int i = 1; i <= self.number; i++){
        CGRect position = self.bounds;
        position.size.height = self.bounds.size.height/1.9;
        position.size.width = shapeWidth;
        position.origin.x = currentXPosition;
        position.origin.y = CGRectGetMidY(self.bounds) - shapeHeight*.5;
        
        currentXPosition += shapeWidth + 7;
        
        UIBezierPath *shape = [UIBezierPath bezierPathWithRoundedRect:position cornerRadius:CORNER_RADIUS];
        
        [shapes addObject:shape];
        
    }
    
    return shapes;
}

@end
