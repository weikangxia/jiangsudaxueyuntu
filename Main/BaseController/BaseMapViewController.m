#import "BaseMapViewController.h"
@implementation BaseMapViewController
@synthesize mapView = _mapView;
@synthesize cloudAPI = _cloudAPI;
@synthesize coordinate = _coordinate;
#pragma mark - Utility
- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    self.mapView.delegate = nil;
}
- (void)clearCloudSearch
{
    self.cloudAPI.delegate = nil;
}
- (void)checkTableID
{
    if ([tableID length] == 0)
    {
        NSLog(@"%@",[NSString stringWithFormat:@"\nSDKVersion:%@\nFILE:%s\nLINE:%d\nMETHOD:%s", [MAMapServices sharedServices].SDKVersion, __FILE__, __LINE__, __func__]);
        NSLog(@"请首先配置APIKey.h中的tableID, 查询tableID参考见 http://yuntu.amap.com");
    }
}
#pragma mark - Handle Action
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self clearMapView];
    [self clearCloudSearch];
}
#pragma mark - AMapSearchDelegate
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}
#pragma mark - AMapSearchDelegate
- (void)cloudRequest:(id)cloudSearchRequest error:(NSError *)error
{
    NSLog(@"CloudRequestError:{Code: %ld; Description: %@}", (long)error.code, error.localizedDescription);
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
    self.mapView.showsUserLocation = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsScale = NO;
    [self.view addSubview:self.mapView];
}
- (void)initCloudSearch
{
    self.cloudAPI.delegate = self;
}
- (void)initSearch
{
    self.search.delegate = self;
}
- (void)initBaseNavigationBar
{
}
#pragma mark - 返回按钮点击事件
- (void)jumpBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self clearMapView];
}
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initBaseNavigationBar];
    [self initMapView];
    [self initCloudSearch];
    [self checkTableID];
    [self initSearch];
}
@end
