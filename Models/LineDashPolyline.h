#import <UIKit/UIKit.h>
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/MAPolyline.h>
#import <AMapNaviKit/MAOverlay.h>
@interface LineDashPolyline :NSObject <MAOverlay>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MAMapRect boundingMapRect;
@property (nonatomic, retain)  MAPolyline *polyline;
- (id)initWithPolyline:(MAPolyline *)polyline;
@end
