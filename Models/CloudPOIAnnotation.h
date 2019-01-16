#import <AMapCloudKit/AMapCloudAPI.h>
#import <AMapNaviKit/AMapNaviKit.h>
@interface CloudPOIAnnotation : NSObject<MAAnnotation>
- (id)initWithCloudPOI:(AMapCloudPOI *)cloudPOI;
@property (nonatomic, readonly, strong) AMapCloudPOI *cloudPOI;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
- (NSString *)title;
- (NSString *)subtitle;
@end
