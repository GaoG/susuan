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

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *startLocation;



@property (nonatomic, strong)UIView *scrollView;

@property (nonatomic, strong)NSMutableArray *labelArr;

@property (nonatomic,strong) SNTimer *gcdTimer;

@property (nonatomic, assign)NSInteger currentIndex;

#define labelHieght  100.0

@end


@implementation NumberScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.startLocation.layer.borderColor = UIColor.whiteColor.CGColor;
    self.startLocation.layer.borderWidth = 1.0f;
    
}

-(void)setSelectedStringArr:(NSMutableArray *)selectedStringArr {
    
    _selectedStringArr = selectedStringArr;
    
    
}


-(void)setDataArr:(NSMutableArray *)dataArr {
    
    _dataArr = dataArr;
    
    
    
    self.scrollView.frame = CGRectMake(0,self.bgView.height/2-(labelHieght/2), SCREEN_WIDTH-200, dataArr.count*labelHieght);
    
    
//    self.scrollView.backgroundColor = UIColor.redColor;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    self.labelArr = [NSMutableArray arrayWithCapacity:_dataArr.count];
    
    for (int i = 0; i<_dataArr.count; i++) {
        UILabel  *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*labelHieght, self.scrollView.width, labelHieght)];
        label.textColor = [UIColor grayColor];
        label.tag = i+1000;
        
        if (i == 0) {
            [label setText:[_dataArr objectAtIndexVerify:i] withKeyWord:[_selectedStringArr objectAtIndexVerify:i] withKeyColor:UIColor.redColor];

        }else {
           [label setText:[_dataArr objectAtIndexVerify:i] withKeyWord:@[] withKeyColor:UIColor.redColor];
        }
        
        [self.scrollView addSubview:label];
    }
    
    self.bgView.clipsToBounds = YES;
    [self.bgView insertSubview:self.scrollView atIndex:0];
//    [self.bgView addSubview:self.scrollView];

 
    
}


/// 开始滚动  设置时间
- (void)scrollWithSpace:(float)space andAnmintTime:(float)time;{
    [_gcdTimer invalidate];
    float tempspace = space/1000 + time/1000 ;
    @weakify(self)
    _gcdTimer = [SNTimer repeatingTimerWithTimeInterval:tempspace block:^{
        @strongify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUI:time];
        });
        
    }];
    self.currentIndex = 0;
    
    
    UILabel *label = [self.scrollView viewWithTag:_currentIndex+1000];
    [label setText:[_dataArr objectAtIndexVerify:_currentIndex] withKeyWord:[self.selectedStringArr objectAtIndexVerify:_currentIndex] withKeyColor:UIColor.redColor];
    
    [_gcdTimer fire];
    
}


-(void)updateUI:(float)time{
    
    _currentIndex ++;
    
//    float typeY = self.scrollView.y;
//    typeY-
    
    float tempTime = time/1000;
//    [UIView animateWithDuration:tempTime animations:^{
    
//       self.scrollView.y -= labelHieght;
//    }];
    
    if (self->_currentIndex >0) {
        
        UILabel *oldLabel = [self.scrollView viewWithTag:self->_currentIndex-1+1000];
        [oldLabel setText:[self->_dataArr objectAtIndexVerify:_currentIndex-1] withKeyWord:@[] withKeyColor:UIColor.redColor];
    }
    
    
    [UIView animateWithDuration:tempTime animations:^{
      self.scrollView.y -= labelHieght;
    } completion:^(BOOL finished) {
//        if (self->_currentIndex >0) {
//
//            UILabel *oldLabel = [self.scrollView viewWithTag:self->_currentIndex-1+1000];
//            [oldLabel setText:[self->_dataArr objectAtIndexVerify:_currentIndex-1] withKeyWord:@[] withKeyColor:UIColor.redColor];
//        }
        
        
        
        
        UILabel *label = [self.scrollView viewWithTag:self->_currentIndex+1000];
        
        //    NSString *selectStr =  [self.selectedStringArr objectAtIndexVerify:_currentIndex];
        
        [label setText:[self->_dataArr objectAtIndexVerify:self->_currentIndex] withKeyWord:[self.selectedStringArr objectAtIndexVerify:self->_currentIndex] withKeyColor:UIColor.redColor];
    }];
    
    

    
    if(_currentIndex == self.dataArr.count ){
        [_gcdTimer invalidate];
        self.scrollEndBlock ? self.scrollEndBlock() : nil;
    }
    
    
    
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
