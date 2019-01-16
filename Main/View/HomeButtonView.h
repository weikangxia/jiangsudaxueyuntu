#import <UIKit/UIKit.h>
@class TCButton;
@protocol HomeButtonViewDelegate <NSObject>
@optional
-(void)buttonViewDidSelect:(TCButton *)selBtn withTag:(NSInteger)tag;
@end
@interface HomeButtonView : UIView
@property (nonatomic , weak) id<HomeButtonViewDelegate> delegate;
- (void)addButtonWithTitle:(NSString *)title imageName:(NSString *)imgName;
@end
