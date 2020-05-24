//
//  ShowNumberView.m
//  Sum
//
//  Created by  GaoGao on 2020/5/24.
//  Copyright © 2020年  GaoGao. All rights reserved.
//

#import "ShowNumberView.h"
#import "UILabel+WordSpacing.h"
@interface ShowNumberView ()

@property (weak, nonatomic) IBOutlet UILabel *NumberL;


@end

@implementation ShowNumberView


- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self.NumberL setText:@"12345" withWordSpacing:50.0];
    
}


/// type 1白色  2黄色
-(void)setText:(NSString *)text andColor:(NSInteger )type {
    
    
    if(type == 2){
        [self.NumberL setTextColor:UIColor.yellowColor];
        
    }else{
        [self.NumberL setTextColor:UIColor.whiteColor];
    }
    
    [self.NumberL setText:text withWordSpacing:50.0];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
