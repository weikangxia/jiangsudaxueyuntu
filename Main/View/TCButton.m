#import "TCButton.h"
#import "appMarco.h"
#define margin 35
@implementation TCButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    [self setTitleColor:[UIColor colorWithWhite:0.098 alpha:1.000] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.layer.borderColor = [[UIColor colorWithWhite:0.800 alpha:1.000]CGColor];
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 0;
    self.layer.masksToBounds = YES;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat Y = contentRect.size.width;
    CGFloat W = contentRect.size.width;
    CGFloat H = margin;
    return CGRectMake(0, Y - 1.5 * margin, W, H);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat W = contentRect.size.width - 2 *margin;
    CGFloat H = W;
    return CGRectMake(margin, margin /2, W, H);
}
@end
