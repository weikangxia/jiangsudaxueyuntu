#import <AMapNaviKit/AMapNaviKit.h>
typedef NS_ENUM(NSInteger, NavPointAnnotationType)
{
    NavPointAnnotationStart,
    NavPointAnnotationWay,
    NavPointAnnotationEnd
};
@interface NavPointAnnotation : MAPointAnnotation
@property (nonatomic) enum NavPointAnnotationType navPointType;
@end
