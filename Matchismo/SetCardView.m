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
#define PATH_WIDTH 3;

//Shapes
#define SHAPE_CIRCLE 1
#define SHAPE_DIAMOND 2
#define SHAPE_SQUIGLE 3

//Shades
#define SHADE_EMPTY 1
#define SHADE_STRIPE 2
#define SHADE_SOLID 3


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
    self.shape = SHAPE_SQUIGLE;
    self.number = 2;
    self.shade = 1;
    
    for(UIBezierPath *shape in [self getShapes]){
        shape.lineWidth = PATH_WIDTH;
        [shape stroke];
        [shape addClip];
        //[[UIColor redColor] setFill];
        UIRectFill(shape.bounds);
        [[UIColor blackColor] setStroke];
        [roundedRect stroke];
    }
    

    

}

/**
 *  This will give us an array of the shapes that we need. 
 */
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
        
        UIBezierPath *shape = [[UIBezierPath alloc]init];
        
        if(self.shape == SHAPE_CIRCLE){
            shape = [UIBezierPath bezierPathWithRoundedRect:position cornerRadius:CORNER_RADIUS];
        }else if(self.shape == SHAPE_DIAMOND){
            [shape moveToPoint:CGPointMake(position.origin.x + position.size.width/2, position.origin.y)];
            [shape addLineToPoint:CGPointMake(position.origin.x + position.size.width, position.origin.y + position.size.height/2)];
            [shape addLineToPoint:CGPointMake(position.origin.x + position.size.width/2, position.origin.y + position.size.height)];
            [shape addLineToPoint:CGPointMake(position.origin.x, position.origin.y + position.size.height/2)];
            [shape closePath];
        }else if(self.shape == SHAPE_SQUIGLE){
            [shape moveToPoint:CGPointMake(position.origin.x + position.size.width/2, position.origin.y)];
            [shape addQuadCurveToPoint:CGPointMake(position.origin.x + position.size.width * .95, position.origin.y + position.size.height * .45)
                          controlPoint:CGPointMake(position.origin.x + position.size.width * 1.5, position.origin.y)];
        }
                
        [shapes addObject:shape];
        
    }
    
    return shapes;
}

@end
