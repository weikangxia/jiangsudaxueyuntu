#import "BaseNaviViewController.h"
#import "MBProgressHUD+MJ.h"
@implementation BaseNaviViewController
#pragma mark - Utility
- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    self.mapView.delegate = nil;
}
#pragma mark - Handle Action
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self clearMapView];
}
#pragma mark - Initialization
- (void)initMapView
{
    if (self.mapView == nil)
    {
        self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    }
    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
}
- (void)initBaseNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(returnAction)];
}
- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
- (void)initIFlySpeech
{
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
}
- (void)initNaviManager
{
    if (self.naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        [_naviManager setDelegate:self];
    }
}
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTitle:self.title];
    [self initBaseNavigationBar];
    [self initMapView];
    [self initNaviManager];
}
#pragma mark - AMapNaviManager Delegate
- (void)AMapNaviManager:(AMapNaviManager *)naviManager error:(NSError *)error
{
    NSLog(@"error:%@",error);
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager didPresentNaviViewController:(UIViewController *)naviViewController
{
    NSLog(@"didPresentNaviViewController");
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager didDismissNaviViewController:(UIViewController *)naviViewController
{
    NSLog(@"didDismissNaviViewController");
}
- (void)AMapNaviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    NSLog(@"OnCalculateRouteSuccess");
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    [MBProgressHUD showError:@"规划失败,请重新选路"];
    NSLog(@"onCalculateRouteFailure");
}
- (void)AMapNaviManagerNeedRecalculateRouteForTrafficJam:(AMapNaviManager *)naviManager
{
    NSLog(@"NeedReCalculateRouteForTrafficJam");
}
- (void)AMapNaviManagerNeedRecalculateRouteForYaw:(AMapNaviManager *)naviManager
{
    NSLog(@"NeedReCalculateRouteForYaw");
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}
- (void)AMapNaviManagerDidEndEmulatorNavi:(AMapNaviManager *)naviManager
{
    NSLog(@"DidEndEmulatorNavi");
}
- (void)AMapNaviManagerOnArrivedDestination:(AMapNaviManager *)naviManager
{
    NSLog(@"OnArrivedDestination");
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint");
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager didUpdateNaviLocation:(AMapNaviLocation *)naviLocation
{
}
- (BOOL)AMapNaviManagerGetSoundPlayState:(AMapNaviManager *)naviManager
{
    return 0;
}
- (void)AMapNaviManager:(AMapNaviManager *)naviManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", soundStringType, soundString);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [_iFlySpeechSynthesizer startSpeaking:soundString];
        NSLog(@"start speak");
    });
}
- (void)AMapNaviManagerDidUpdateTrafficStatuses:(AMapNaviManager *)naviManager
{
    NSLog(@"DidUpdateTrafficStatuses");
}
#pragma mark - iFlySpeechDelegate
- (void)onCompleted:(IFlySpeechError*) error
{
    NSLog(@"Speak Error:{%d:%@}", error.errorCode, error.errorDesc);
}
@end
