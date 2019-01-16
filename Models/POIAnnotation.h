#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>
@interface POIAnnotation : NSObject <MAAnnotation>
- (id)initWithPOI:(AMapPOI *)poi;
@property (nonatomic, readonly, strong) AMapPOI *poi;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;
@end
