//
//  BNRHypnosisView.m
//  test_chapter5
//
//  Created by admin on 2019/2/28.
//  Copyright © 2019年 sk. All rights reserved.
//

#import "BNRHypnosisView.h"

// 类扩展
@interface BNRHypnosisView ()

@property (strong,nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView


-  (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [ UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 显示范围
    CGRect bounds = self.bounds;
    // Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width  / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // 求斜边边长
    float maxRadius = hypot(bounds.size.width, bounds.size.height);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (float currentRadius = maxRadius;currentRadius > 0) {
        
    }
}

@end
