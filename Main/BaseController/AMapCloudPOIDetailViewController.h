#import <UIKit/UIKit.h>
#import <AMapCloudKit/AMapCloudAPI.h>
@interface AMapCloudPOIDetailViewController : UIViewController
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, strong) AMapCloudPOI *cloudPOI;
@end
