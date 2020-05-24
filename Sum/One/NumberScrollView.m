//
//  NumberScrollView.m
//  Sum
//
//  Created by  GaoGao on 2020/5/23.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "NumberScrollView.h"
#import "UIView+Category.h"
#import "UILabel+WordSpacing.h"
#import "ConfigHeader.h"
#import "SNTimer.h"
#import "NSArray+ErrorHandle.h"

@interface NumberScrollView ()

@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;

@property (weak, nonatomic) IBOutlet UIView *blackView;

@property (nonatomic, strong)UIView *scrollView;

@property (nonatomic, strong)NSMutableArray *labelArr;

@property (nonatomic,strong) SNTimer *gcdTimer;

@property (nonatomic, assign)NSInteger currentIndex;


@end


@implementation NumberScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
    self.scrollView.frame = CGRectMake(0, self.blackView.height/2-35, SCREEN_WIDTH-200, dataArr.count*70);
//    self.scrollView.backgroundColor = UIColor.redColor;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.labelArr = [NSMutableArray arrayWithCapacity:_dataArr.count];
    
    for (int i = 0; i<_dataArr.count; i++) {
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*70, self.scrollView.width, 70)];
        label.textColor = [UIColor grayColor];
        label.tag = i+1000;
        [label setText:_dataArr[i] withKeyWord:@[] withKeyColor:UIColor.redColor];
        [self.scrollView addSubview:label];
    }
    
    self.blackView.clipsToBounds = YES;
    [self.blackView addSubview:self.scrollView];
    [_gcdTimer invalidate];
    _gcdTimer = nil;
    @weakify(self)
    _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:1 block:^{
        @strongify(self)
        [self updateUI];
    }];
    self.currentIndex = 0;
    [_gcdTimer fire];
    
}




-(void)updateUI{
    
    _currentIndex ++;
    
    float typeY = self.scrollView.y;
    
    self.scrollView.y = typeY-70;
    
    
    UILabel *oldLabel = [self.scrollView viewWithTag:_currentIndex-1+1000];
    
    [oldLabel setText:[_dataArr objectAtIndexVerify:_currentIndex-1] withKeyWord:@[] withKeyColor:UIColor.redColor];
    
    
   UILabel *label = [self.scrollView viewWithTag:_currentIndex+1000];
    
     [label setText:[_dataArr objectAtIndexVerify:_currentIndex] withKeyWord:@[@"1",@"4",@"6",@"8"] withKeyColor:UIColor.redColor];
    
    
    _currentIndex == self.dataArr.count ? [_gcdTimer stop] :nil;
    
    
}

-(void)ceshi:(BOOL)state withView:(UIView *)view {
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.fillMode = kCAFillModeForwards;
    theAnimation.duration=.0001;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat: state ? 3.1415926 : 0.0];
    [view.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
}




-(UIView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIView alloc]init];
    }
    
    return _scrollView;
    
}

//-(SNTimer *)gcdTimer {
//
//    if(!_gcdTimer){
//        __weak id weakSelf = self;
//
//        _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:.5 block:^{
//            [weakSelf updateTime];
//        }];
//
//    }
//    return _gcdTimer;
//}

@end
