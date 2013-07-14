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
#define PATH_WIDTH 2;
#define PATH_SHADE_WIDTH 1;

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

//For testing
//    self.faceUp = true;
//    self.color = [UIColor purpleColor];
//    self.number = 2;
//    self.shape  = SHAPE_DIAMOND;
//    self.shade  = SHADE_STRIPE;

    if (self.faceUp) {
        [[UIColor colorWithHue:.56 saturation:.17 brightness:.92 alpha:1] setFill];
        UIRectFill(self.bounds);
        
    } else{
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
    }
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    NSArray *shapes = [self getShapes];
    
    for(UIBezierPath *shape in shapes){
        
        [self addShadeToShape:shape];        
    }

}

- (void)addShadeToShape:(UIBezierPath *)shape
{
    shape.lineWidth = PATH_WIDTH;
    
    [[UIColor whiteColor] setFill];
    
    [self.color setStroke];
    
    [self pushContext];
    [shape addClip];

    UIRectFill(self.bounds);
    
    if(self.shade == SHADE_SOLID){
        [self.color setFill];
        UIRectFill(self.bounds);
    }else if(self.shade == SHADE_STRIPE){
        CGFloat originX = shape.bounds.origin.x;
        CGFloat originY = shape.bounds.origin.y;
        CGFloat width = shape.bounds.size.width;
        CGFloat height = shape.bounds.size.height;

        UIBezierPath *line = [[UIBezierPath alloc] init];

        for(int i = 3; i < height; i+= 4){
            line.lineWidth = PATH_SHADE_WIDTH;
            [line moveToPoint:CGPointMake(originX, originY + i)];
            [line addLineToPoint:CGPointMake(originX + width, originY + i)];
            [line stroke];
        }
        
    }
    
    [self popContext];
    
    
    //Add the stroke last so it's on top. Probably not important here because the fill color is the same
    //  but worth noting the the order of drawing operations matters
    [shape stroke];
    
    
}

- (void)pushContext
{
    CGContextSaveGState(UIGraphicsGetCurrentContext());
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (CGRect) getCGRectShapePositionWithIndex:(int)shapeIndex
{
    CGFloat shapeWidth = self.bounds.size.width/5.5;
    CGFloat shapeHeight = self.bounds.size.height/1.6;
    CGFloat currentXPosition = CGRectGetMidX(self.bounds) -(self.number * shapeWidth * .6) + (shapeWidth + 7)*(shapeIndex-1);
    CGRect position = self.bounds;
    position.size.height = shapeHeight;
    position.size.width = shapeWidth;
    position.origin.x = currentXPosition;
    position.origin.y = CGRectGetMidY(self.bounds) - shapeHeight*.5;
    
    return position;
}

/**
 *  This will give us an array of the shapes that we need.
 */
- (NSArray *)getShapes
{
    NSMutableArray *shapes = [[NSMutableArray alloc] init];
    
    for(int i = 1; i <= self.number; i++){

        CGRect position = [self getCGRectShapePositionWithIndex:i];
        
        UIBezierPath *shape = [[UIBezierPath alloc]init];
        
        CGFloat originX = position.origin.x;
        CGFloat originY = position.origin.y;
        CGFloat height = position.size.height;
        CGFloat width = position.size.width;
        
        if(self.shape == SHAPE_CIRCLE){
            shape = [UIBezierPath bezierPathWithRoundedRect:position cornerRadius:CORNER_RADIUS];
        }else if(self.shape == SHAPE_DIAMOND){
            [shape moveToPoint:CGPointMake(originX + width/2, originY)];
            [shape addLineToPoint:CGPointMake(originX + width, originY + height/2)];
            [shape addLineToPoint:CGPointMake(originX + width/2, originY + height)];
            [shape addLineToPoint:CGPointMake(originX, originY + height/2)];
            [shape closePath];
        }else if(self.shape == SHAPE_SQUIGLE){
            [shape moveToPoint:CGPointMake(originX + width/2, originY)];
            
            [shape addQuadCurveToPoint:CGPointMake(originX + width * .95, originY + height * .45)
                          controlPoint:CGPointMake(originX + width * 1.5, originY)];
            
            [shape addQuadCurveToPoint:CGPointMake(originX + width, originY + height*.9)
                          controlPoint:CGPointMake(originX + width*.7, originY + height*.75)];
            
            [shape addQuadCurveToPoint:CGPointMake(originX + width*.1, originY + height*.65)
                          controlPoint:CGPointMake(originX + width*.65, originY + height*1.3)];
            
            [shape addQuadCurveToPoint:CGPointMake(originX + width*.05, originY + height*.1)
                          controlPoint:CGPointMake(originX + width*.45, originY + height*.45)];
            
            [shape addQuadCurveToPoint:CGPointMake(originX + width/2, originY)
                          controlPoint:CGPointMake(originX, originY)];

        }
                
        [shapes addObject:shape];
        
    }
    
    return shapes;
}

@end
