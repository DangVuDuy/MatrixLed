//
//  ViewController.m
//  MatrixLed
//
//  Created by Duy Dang on 12/11/15.
//  Copyright © 2015 Duy Dang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    CGFloat _margin; //> ball radius
    int _numberOfBall;
    CGFloat _space; //> bal diameter
    CGFloat _ballDiameter;
    NSTimer* _timer;
    int _numberRow;
    int _numberColumn;
    int lastOnLED;
    
    
}


- (void)viewDidLoad {
    _margin = 40.0;
    _ballDiameter = 24.0;
    _numberRow = 8;
    _numberColumn = 8;
    _numberOfBall = _numberRow* _numberColumn;
    lastOnLED = _numberOfBall;
    [super viewDidLoad];
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    [self numberOfBallvsSpace1];
    [self drawRowOfBalls:_numberRow anddrawColumnOfBalls:_numberColumn];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(runningLed) userInfo:nil repeats:true];
    
    
}
- (void) runningLed {
    if (lastOnLED != _numberOfBall) {
        [self turnOFFLed:lastOnLED];
    }
    
    if (lastOnLED != 0) {
        lastOnLED--;
    } else {  //Reach the last LED in row, move to first LED
        lastOnLED = _numberOfBall - 1;
    }
    [self turnONLed:lastOnLED];
}
- (void) turnONLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"green"];
        
    }
}
- (void) turnOFFLed: (int) index {
    UIView* view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView* ball = (UIImageView*) view;
        ball.image = [UIImage imageNamed:@"gray"];
        
    }
}

- (void) placeGrayBallAtX: (CGFloat) x
                     andY: (CGFloat) y
                  withTag: (int)tag
{
    UIImageView* ball = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"gray"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview:ball];
    //NSLog(@"w = %3.0f, h = % 3.0f", ball.bounds.size.width, ball.bounds.size.height);
}
- (CGFloat) spaceBetweenBallCenterWhenNumberBallIsKnown: (int) n {
    return (self.view.bounds.size.width - 2 * _margin) / (n - 1);
}
-(CGFloat) spaceBetweenBallCenterWhenNumberOfBallIsKnown1 : (int) m {
    return (self.view.bounds.size.height - 2* _margin) / (m-1);
}
- (void) numberOfBallvsSpace {
    bool stop = false;
    int n = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberBallIsKnown: n];
        if (space < _ballDiameter) {
            stop = true;
            
        }
        else{
            //NSLog(@"Number of ball %d, space between ball center %3.0f", n, space);
        }
        n++;
    }
    
}
- (void) numberOfBallvsSpace1 {
    bool stop = false;
    int m = 3;
    while (!stop) {
        CGFloat space = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown1 : m];
        if (space < _ballDiameter) {
            stop = true;
        } else {
            //NSLog(@"number of ball %d and space %3.0f",m,space);
        }
        m++;
    }
    
}
- (void) drawRowOfBalls: (int) numberBallRow anddrawColumnOfBalls: (int) numberBallColumn  {
    CGFloat space1 = [self spaceBetweenBallCenterWhenNumberBallIsKnown:numberBallRow];
    CGFloat space2 = [self spaceBetweenBallCenterWhenNumberOfBallIsKnown1:numberBallColumn];
    for (int i = 0; i < numberBallRow; i++) {
        for (int j = 0; j < numberBallColumn; j ++)
            [self placeGrayBallAtX: _margin + i * space1
                              andY: _margin +j * space2
                           withTag: 100 + i* numberBallColumn +j];
        
        
        
    }
    
    
}


-(void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width = %3.0f, height = %3.0f", size.width, size.height);
}
@end
