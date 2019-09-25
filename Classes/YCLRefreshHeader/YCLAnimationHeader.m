//
//  YCLAnimationHeader.m
//  customer
//
//  Created by 木木木 on 2017/9/13.
//  Copyright © 2017年 Ningbo Otoc Automobile Service Co.,ltd. All rights reserved.
//

#import "YCLAnimationHeader.h"

@interface YCLAnimationHeader (){
    __unsafe_unretained UIImageView *_OTOC;
}

@end

@implementation YCLAnimationHeader

#pragma mark - 懒加载
- (UIImageView *)OTOCView
{
    if (!_OTOC) {
        
        UIImage * car = [[UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"YCLAnimationHeader" ofType:@"bundle"]] pathForResource:@"carPD" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage * tyrePD = [[UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"YCLAnimationHeader" ofType:@"bundle"]] pathForResource:@"tyrePD" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        UIImageView *OTOC = [[UIImageView alloc]initWithImage:car];
//        UIImageView *OTOC = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"carPD.png"]];
        [OTOC.layer addSublayer:[[UIImageView alloc]initWithImage:tyrePD].layer];
        [OTOC.layer addSublayer:[[UIImageView alloc]initWithImage:tyrePD].layer];
        
//        OTOC.tintColor = UIColor.grayColor;
        
        [self addSubview:(_OTOC = OTOC)];
    }
    return _OTOC;
}


#pragma mark - 实现父类的方法
- (void)prepare
{
    [super prepare];
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    if (self.state != MJRefreshStateIdle) return;
    // 停止动画
    [self stopAnimating];
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.OTOCView.constraints.count) return;
    self.automaticallyChangeAlpha = YES;
    CGFloat VMargin = 15.0;
    
    self.OTOCView.bounds = CGRectMake(0, 0, (CGRectGetHeight(self.bounds) - VMargin * 2) * 4.2, (CGRectGetHeight(self.bounds) - VMargin * 2));
    self.OTOCView.center = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
    
    CGFloat scaleFactoer = self.OTOCView.bounds.size.width/125.0;
    
    for (int i = 0; i < self.OTOCView.layer.sublayers.count; i ++) {
        CALayer *layer = self.OTOCView.layer.sublayers[i];
        if (i == 0) {
            layer.bounds = CGRectMake(0, 0, 16 * scaleFactoer, 16 * scaleFactoer);
            layer.position = CGPointMake(30 * scaleFactoer, 23 * scaleFactoer);
        }else if (i == 1){
            layer.bounds = CGRectMake(0, 0, 16 * scaleFactoer, 16 * scaleFactoer);
            layer.position = CGPointMake(69 * scaleFactoer, 23 * scaleFactoer);
        }else{
            break;
        }
    }
    
}




- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStatePulling || state == MJRefreshStateRefreshing) {
        [self startAnimating];
    } else if (state == MJRefreshStateIdle) {
        [self stopAnimating];
    }
}


- (void)startAnimating{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @0;
    rotation.toValue = @(- M_PI * 20 * 3);
    
    rotation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25 : 0.35 : 0.75 : 0.65];
    //    rotation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.15 : 0.05 : 0.85 : 0.95];
    rotation.repeatCount = INFINITY;
    rotation.duration = 0.318 * 10 * 3;
    

    for (CALayer *layer in self.OTOCView.layer.sublayers) {
        [layer addAnimation:rotation forKey:@"rotation"];
    }
}

- (void)stopAnimating{
    for (CALayer *layer in self.OTOCView.layer.sublayers) {
        [layer removeAllAnimations];
    }
}

@end
