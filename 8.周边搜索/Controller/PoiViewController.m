#import "PoiViewController.h"
#import "POIAnnotation.h"
#import "PoiDetailViewController.h"
#import "CommonUtility.h"
#define GeoPlaceHolder @"周边搜索"
@interface PoiViewController ()<UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
     BOOL _hasCurrLoc; 
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *displayController;
@property (nonatomic, strong) NSMutableArray *searchResultAnnos;
@property (nonatomic, assign)  CLLocationCoordinate2D center2D;
@end
@implementation PoiViewController
#pragma mark - Initialization 初始化搜索框
- (void)initSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = GeoPlaceHolder;
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.tintColor = appMainColor;
    self.searchBar.hidden = NO;
    [self.view addSubview:self.searchBar];
}
- (void)initSearchDisplay
{
    self.displayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.displayController.searchBar.backgroundColor = [UIColor clearColor];
    self.displayController.delegate                = self;
    self.displayController.searchResultsDataSource = self;
    self.displayController.searchResultsDelegate   = self;
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *key = searchBar.text;
    [self aroundLocalSearchWithKey:key];
    [self.displayController setActive:NO animated:YES];
    self.searchBar.placeholder = key;
}
#pragma mark - UISearchDisplayDelegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self aroundLocalSearchWithKey:searchString];
    return YES;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultAnnos.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
    }
    AMapPOI * aPOI = self.searchResultAnnos[indexPath.row];
    cell.textLabel.text = aPOI.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ 【距离我:%ld米】",aPOI.address,(long)aPOI.distance];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.displayController setActive:NO animated:NO];
    AMapPOI * aPOI = self.searchResultAnnos[indexPath.row];
    POIAnnotation *ann = [[POIAnnotation alloc]initWithPOI:aPOI];
    CLLocationCoordinate2D centerCoordinate;
    centerCoordinate.latitude = aPOI.location.latitude;
    centerCoordinate.longitude = aPOI.location.longitude;
    [self.mapView setZoomLevel:16.0f animated:YES];
    [self.mapView setCenterCoordinate:centerCoordinate];
    [self performSelector:@selector(beSelectAnnotation:) withObject:ann afterDelay:0.4];
     self.searchBar.placeholder = aPOI.name;
}
-(void)beSelectAnnotation:(POIAnnotation *)obj
{
    [self.mapView addAnnotation:obj];
    [self.mapView selectAnnotation:obj animated:YES];
}
#pragma mark - 点击搜索按钮隐藏
-(void)toSearchLocation
{
    self.searchBar.hidden = !self.searchBar.hidden;
}
#pragma mark - 定位用户当前坐标按钮点击事件
- (void)locationBtn
{
    _hasCurrLoc = NO;
    self.mapView.showsUserLocation = YES;
}
#pragma mark - 本地关键字搜索
- (void)aroundLocalSearchWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    request.searchType          = AMapSearchType_PlaceAround;
    request.radius              = 5000; 
    if (_hasCurrLoc) {
       request.location         = [AMapGeoPoint locationWithLatitude:self.center2D.latitude longitude:self.center2D.longitude];
    }
    else
    {
       request.location         = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    }
    request.keywords            = key;
    request.sortrule            = 1;
    request.offset              = 200;
    request.page                = 1;
    request.requireExtension    = YES;
    [self.search AMapPlaceSearch:request];
}
#pragma mark - 初始化大头针
- (void)addAnnotationsWithPOIs:(NSArray *)pois
{
    for (id<MAAnnotation> annotation in  self.mapView.annotations)
    {
        if ([annotation isKindOfClass:[POIAnnotation class]])
        {
            [self.mapView removeAnnotation:annotation];
        }
    }
    for (AMapPOI *aPOI in pois)
    {
        POIAnnotation *ann = [[POIAnnotation alloc]initWithPOI:aPOI];
        [self.mapView addAnnotation:ann];
    }
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}
#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (!_hasCurrLoc)
    {
        _hasCurrLoc = YES;
        self.center2D = userLocation.coordinate;
        [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        [self.mapView setZoomLevel:16 animated:YES];
    }
}
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    id<MAAnnotation> annotation = view.annotation;
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        self.navigationItem.backBarButtonItem = backItem;
        POIAnnotation *poiAnnotation = (POIAnnotation*)annotation;
        PoiDetailViewController *detail = [[PoiDetailViewController alloc] init];
        detail.poi = poiAnnotation.poi;
        [self.navigationController pushViewController:detail animated:YES];
    }
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[POIAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                                reuseIdentifier:poiIdentifier];
        }
        poiAnnotationView.canShowCallout            = YES;
        poiAnnotationView.image = [UIImage imageNamed:@"cloudPoint"];
        UIButton * rightAccessoryView= [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightAccessoryView.tintColor = [UIColor colorWithRed:0.270 green:0.633 blue:1.000 alpha:1];
        poiAnnotationView.rightCalloutAccessoryView = rightAccessoryView;
        return poiAnnotationView;
    }
    return nil;
}
#pragma mark - AMapSearchDelegate
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)respons
{
    [self.searchResultAnnos setArray:respons.pois];
    [self addAnnotationsWithPOIs:[respons pois]];
    [self.displayController.searchResultsTableView reloadData];
    UILabel * counts = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    counts.textAlignment = NSTextAlignmentCenter;
    counts.textColor = appMainColor;
    counts.text = [NSString stringWithFormat:@"共搜索到%ld条",respons.count];
    self.displayController.searchResultsTableView.tableHeaderView = counts;
}
- (void)searchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"search Error");
}
#pragma mark - Utility
- (void)searchPoiByCenterCoordinate
{
    AMapPlaceSearchRequest *request = [[AMapPlaceSearchRequest alloc] init];
    request.searchType          = AMapSearchType_PlaceAround;
    request.location            = [AMapGeoPoint locationWithLatitude:25.063072 longitude:110.303577];
    request.keywords            = @"ATM";
    request.sortrule            = 1;
    request.requireExtension    = YES;
    [self.search AMapPlaceSearch:request];
}
- (void)clearSearchPois
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
}
#pragma mark - Initialization
-(void)initNavBar
{
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = [UIFont boldSystemFontOfSize:18];
    titleLabel.text             = @"周边搜索";
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"searchBtn"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 23, 23)];
    [button addTarget:self action:@selector(toSearchLocation) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}
-(void)initLocationBtn
{
    UIButton * btnLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLocation setBackgroundColor:[UIColor clearColor]];
    [btnLocation setBackgroundImage:[UIImage imageNamed:@"default_main_gpsbutton_background_normal"] forState:UIControlStateNormal];
    [btnLocation setImage:[UIImage imageNamed:@"default_main_gpsnormalbutton_image_normal"] forState:UIControlStateNormal];
    [btnLocation setImage:[UIImage imageNamed:@"default_main_gpsnormalbutton_image_disabled"] forState:UIControlStateHighlighted];
    [btnLocation setContentMode:UIViewContentModeCenter];
    [btnLocation setFrame:CGRectMake(self.view.bounds.size.width-65, self.view.bounds.size.height-65, 45, 45)];
    [btnLocation setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin];
    [btnLocation addTarget:self action:@selector(locationBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLocation];
    [self.view bringSubviewToFront:btnLocation];
}
-(void)initMapView
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
    self.mapView.zoomLevel = 16;
    [self.view addSubview:self.mapView];
     _hasCurrLoc = NO;
}
#pragma mark - Life Cycle
- (id)init
{
    if (self = [super init])
    {
        self.searchResultAnnos = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initNavBar];
    [self clearSearchPois];
    [self initMapView];
    [self initLocationBtn];
    [self initSearchBar];
    [self initSearchDisplay];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
}
@end
