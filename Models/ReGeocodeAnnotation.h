#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>
@interface ReGeocodeAnnotation : NSObject <MAAnnotation>
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate reGeocode:(AMapReGeocode *)reGeocode;
@property (nonatomic, readonly, strong) AMapReGeocode *reGeocode;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;
@end
