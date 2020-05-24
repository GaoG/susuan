//
//  ViewController.m
//  Sum
//
//  Created by  GaoGao on 2020/5/22.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ViewController.h"
#import "IpConfigView.h"
#import "CountDownView.h"
#import "StartView.h"
#import "SubmitView.h"
#import "NumberScrollView.h"
#import "ConfigHeader.h"
#import "ProgressView.h"

#import "SecondViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UIView *scrollview;

@property (nonatomic, strong)IpConfigView *configView;

@property (nonatomic, strong)CountDownView *countDownView;

@property (nonatomic, strong)StartView *startView;

@property (nonatomic, strong)SubmitView *submitView;

@property (nonatomic, strong)NumberScrollView *numberScrollView;

@property (nonatomic, strong)ProgressView *progressView;


@property (nonatomic, strong)NSMutableArray *viewArr;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//        [self performSelector:@selector(ceshi) withObject:nil afterDelay:0];
    
    

    
    self.progressView.frame = self.view.bounds;
    [self.view addSubview:self.progressView];
    
    
    self.configView.frame = self.view.bounds;
    
    [self.view addSubview:self.configView];
    
    
    
    self.countDownView.frame = self.view.bounds;
    [self.view addSubview:self.countDownView];
    
    [self.countDownView countDownBegin:6];
    
    self.startView.frame = self.view.bounds;
    [self.view addSubview:self.startView];
    
    

    self.submitView.frame = self.view.bounds;
    [self.view addSubview:self.submitView];
//    [self.submitView start];
    
    
    self.numberScrollView.frame = self.view.bounds;
    [self.view addSubview:self.numberScrollView];

    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i= 0; i<20; i++) {
        int a = arc4random() % 10000000000000;
        
        NSString *str = [NSString stringWithFormat:@"%010d", a];
        
//        NSString * text = [NSString stringWithFormat:@"%u",arc4random()];
        [arr addObject:str];
    }
   
    self.numberScrollView.dataArr = arr;
    
    
    [self.viewArr addObjectsFromArray:@[self.configView,self.configView,self.countDownView,self.startView,self.submitView,self.numberScrollView,self.progressView]];
    
    
}


-(void)ceshi {
    
//    self.startView.hidden = YES;
    SecondViewController *VC = [[SecondViewController alloc]init];
    
    [self presentViewController:VC animated:YES completion:nil];
    
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



#pragma mark  隐藏或显示某个view

-(void)operateView:(UIView *)view withState:(BOOL)state {
    
    for (UIView *sub in self.viewArr) {
        
        if (sub == view) {
            sub.hidden = state;
        }else{
           sub.hidden = !state;
        }
        
    }
}



-(IpConfigView *)configView {
    
    
    if (!_configView) {
        _configView = [[[NSBundle mainBundle]loadNibNamed:@"IpConfigView" owner:nil options:nil]lastObject];
        
        @weakify(self)
        _configView.connectBlock = ^(NSString * _Nonnull mainIP, NSString * _Nonnull ID, NSString * _Nonnull listIP, NSString * _Nonnull audienceIP, NSInteger type) {
            @strongify(self)
            NSLog(@"%@",self);
        };
        
    }
    
    
    return _configView;
}


-(CountDownView *)countDownView {
    
    if (!_countDownView) {
        _countDownView = [[[NSBundle mainBundle]loadNibNamed:@"CountDownView" owner:nil options:nil]lastObject];
        
        _countDownView.endBlock = ^{
            
        };
        
    }
    
    
    return _countDownView;
}



-(StartView *)startView {
    
    if (!_startView) {
        _startView = [[[NSBundle mainBundle]loadNibNamed:@"StartView" owner:nil options:nil]lastObject];
    }
    
    
    return _startView;
}



-(SubmitView *)submitView {
    
    if (!_submitView) {
        _submitView = [[[NSBundle mainBundle]loadNibNamed:@"SubmitView" owner:nil options:nil]lastObject];
        
    }
    
    
    return _submitView;
}

-(NumberScrollView *)numberScrollView {
    
    if (!_numberScrollView) {
        _numberScrollView = [[[NSBundle mainBundle]loadNibNamed:@"NumberScrollView" owner:nil options:nil]lastObject];
        
    }
    
    return _numberScrollView;
}


-(ProgressView *)progressView {
    
    if (!_progressView) {
        _progressView = [[[NSBundle mainBundle]loadNibNamed:@"ProgressView" owner:nil options:nil]lastObject];
        
    }
    
    return _progressView;
}

-(NSMutableArray *)viewArr{
    
    if (!_viewArr) {
        _viewArr = [NSMutableArray array];
    }
    return _viewArr;
    
}

@end
