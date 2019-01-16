#import "CloudPOIAnnotation.h"
@interface CloudPOIAnnotation ()
@property (nonatomic, readwrite, strong) AMapCloudPOI *cloudPOI;
@end
@implementation CloudPOIAnnotation
@synthesize cloudPOI = _cloudPOI;
#pragma mark - MAAnnotation Protocol
- (NSString *)title
{
    return [NSString stringWithFormat:@"%@", self.cloudPOI.name];
}
- (NSString *)subtitle
{
    return [NSString stringWithFormat:@"【%@】  距离我%ld 米",[self.cloudPOI.customFields valueForKey:@"type"],(long)self.cloudPOI.distance];
}
- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake(self.cloudPOI.location.latitude, self.cloudPOI.location.longitude);
}
#pragma mark - Life Cycle
- (id)initWithCloudPOI:(AMapCloudPOI *)cloudPOI
{
    if (self = [super init])
    {
        self.cloudPOI = cloudPOI;
    }
    return self;
}
@end
