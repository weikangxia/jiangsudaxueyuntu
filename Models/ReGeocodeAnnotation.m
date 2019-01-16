#import "ReGeocodeAnnotation.h"
@interface ReGeocodeAnnotation ()
@property (nonatomic, readwrite, strong) AMapReGeocode *reGeocode;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@end
@implementation ReGeocodeAnnotation
@synthesize reGeocode  = _reGeocode;
@synthesize coordinate = _coordinate;
#pragma mark - MAAnnotation Protocol
- (NSString *)title
{
    return [NSString stringWithFormat:@"%@%@%@",
            self.reGeocode.addressComponent.city,
            self.reGeocode.addressComponent.district,
            self.reGeocode.addressComponent.township];
}
- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"%@%@",
            self.reGeocode.addressComponent.neighborhood,
            self.reGeocode.addressComponent.building];
}
#pragma mark - Life Cycle
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate reGeocode:(AMapReGeocode *)reGeocode
{
    if (self = [super init])
    {
        self.coordinate = coordinate;
        self.reGeocode  = reGeocode;
    }
    return self;
}
@end
