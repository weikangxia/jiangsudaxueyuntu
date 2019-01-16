#import "HomeButtonView.h"
#import "TCButton.h"
#define margin 0
#define navBarHight (iPhone_X_S ? 87 : 63)
#define iPhone_X_S ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && ([UIScreen mainScreen].bounds.size.height == 812.0 || [UIScreen mainScreen].bounds.size.height == 896.0))
@implementation HomeButtonView
- (void)addButtonWithTitle:(NSString *)title imageName:(NSString *)imgName
{
    TCButton *button = [TCButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)buttonClick:(TCButton *)button
{
    if ([self.delegate respondsToSelector:@selector(buttonViewDidSelect:withTag:)]) {
        [self.delegate buttonViewDidSelect:button withTag:button.tag];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 140;
    self.frame = CGRectMake(0, navBarHight, width, height);
    CGFloat butoonW = (width - 4 * margin) /3;
    CGFloat butoonH = butoonW + margin;
    int totalColumns = 3;
    int count = (int)self.subviews.count;
    for (int i = 0; i<count; i++) {
        TCButton *butoon = self.subviews[i];
        int row = i / totalColumns;
        int col = i % totalColumns;
        CGFloat butoonX = margin + col * (margin + butoonW);
        CGFloat butoonY = row * (margin + butoonH);
        butoon.frame = CGRectMake(butoonX, butoonY, butoonW, butoonH);
        butoon.tag = i;
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
}
- (void)drawRect:(CGRect)rect
{
}
@end
