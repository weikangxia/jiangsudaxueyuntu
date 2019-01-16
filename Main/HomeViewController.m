#import "HomeViewController.h"
#import "HomeButtonView.h"
#import "appMarco.h"
#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "BaseMapViewController.h"
#import "CloudPlaceAroundSearchViewController.h"
#import "AllMapCloudViewController.h"
#import "AddMapCloudViewController.h"
#import "BaseNaviViewController.h"
#import "NavigationViewController.h"
#import "MapTypeViewController.h"
#import "MyLocationViewController.h"
#import "PoiViewController.h"
#import "SettingViewController.h"
#import "InvertGeoViewController.h"
#define TCCoror(a,b,c) [UIColor colorWithRed:(a/255.0) green:(b/255.0) blue:(c/255.0) alpha:1]
@interface HomeViewController ()<MAMapViewDelegate,HomeButtonViewDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapCloudAPI *cloud;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) AMapSearchAPI *search;
@end
@implementation HomeViewController
#pragma mark - Life Cycle
- (id)init
{
    if (self = [super init])
    {
        [self initSearch];
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        if (self.mapView == nil) {
            self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        }
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = YES;    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithTitle:@"江苏大学云图"];
    [self initWithRights];
    HomeButtonView *myButoon = [[HomeButtonView alloc] init];
    myButoon.delegate = self;
    [self.view addSubview:myButoon];
    [myButoon addButtonWithTitle:@"江大云图" imageName:@"jscloud"];
    [myButoon addButtonWithTitle:@"全部云图" imageName:@"allCloud"];
    [myButoon addButtonWithTitle:@"添加云图" imageName:@"addCloud"];
    [myButoon addButtonWithTitle:@"导航图" imageName:@"navigationMap"];
    [myButoon addButtonWithTitle:@"卫星图" imageName:@"inDoor"];
    [myButoon addButtonWithTitle:@"信息图" imageName:@"covers"];
    [myButoon addButtonWithTitle:@"我的位置" imageName:@"myLocation"];
    [myButoon addButtonWithTitle:@"周边搜索" imageName:@"roundSearch"];
    [myButoon addButtonWithTitle:@"应用设置" imageName:@"seting"];
}
-(void)buttonViewDidSelect:(TCButton *)selBtn withTag:(NSInteger)tag
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    if (tag == 0) {
        BaseMapViewController *subViewController = [[CloudPlaceAroundSearchViewController alloc] init];
        subViewController.cloudAPI      = [[AMapCloudAPI alloc] initWithCloudKey:(NSString *)APIKey delegate:nil];
        subViewController.coordinate = self.coordinate;
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 1)
    {
        BaseMapViewController *subViewController = [[AllMapCloudViewController alloc] init];
        subViewController.cloudAPI      = [[AMapCloudAPI alloc] initWithCloudKey:(NSString *)APIKey delegate:nil];
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 2)
    {
        AddMapCloudViewController *addViewController = [[AddMapCloudViewController alloc] init];
        [self.navigationController pushViewController:addViewController animated:YES];
    }
    else if(tag == 3)
    {
        BaseNaviViewController *subViewController = [[NavigationViewController alloc] init];
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 4)
    {
        BaseMapViewController *subViewController = [[MapTypeViewController alloc] init];
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 5)
    {
        BaseMapViewController *subViewController = [[InvertGeoViewController alloc] init];
        subViewController.search  = self.search;
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 6)
    {
        MyLocationViewController *subViewController = [[MyLocationViewController alloc] init];
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 7)
    {
        BaseMapViewController *subViewController = [[PoiViewController alloc] init];
        subViewController.search  = self.search;
        [self.navigationController pushViewController:(UIViewController*)subViewController animated:YES];
    }
    else if(tag == 8)
    {
        SettingViewController * setVer = [[SettingViewController alloc]init ];
       [self.navigationController pushViewController:setVer animated:YES];
    }
}
#pragma mark - Initialization
- (void)initSearch
{
    self.search = [[AMapSearchAPI alloc] initWithSearchKey:[MAMapServices sharedServices].apiKey Delegate:nil];
}
#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
{
    self.coordinate = userLocation.coordinate;
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
}
#pragma mark - init
-(void)initWithTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = [UIFont boldSystemFontOfSize:21];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
-(void)initWithRights
{
    UILabel * htc = [[UILabel alloc]init];
    htc.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.95);
    htc.bounds = CGRectMake(0, 0, self.view.frame.size.width, 80);
    htc.textAlignment = NSTextAlignmentCenter;
    htc.textColor = TCCoror(147, 147, 147);
    htc.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:htc];
    UILabel * rights = [[UILabel alloc]init];
    rights.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.97);
    rights.bounds = CGRectMake(0, 0, self.view.frame.size.width, 80);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    rights.text = [NSString stringWithFormat:@"©%@ @Weikang Xia All rights reserved", yearString];
    rights.textAlignment = NSTextAlignmentCenter;
    rights.textColor = TCCoror(147, 147, 147);
    rights.font = [UIFont systemFontOfSize:11];
    [self.view addSubview:rights];
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
}
@end
