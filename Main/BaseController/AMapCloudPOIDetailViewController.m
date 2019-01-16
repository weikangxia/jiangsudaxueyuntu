#import "AMapCloudPOIDetailViewController.h"
#import "appMarco.h"
#import "AFNetworking.h"
#import "PhotoBrowserController.h"
#import "MBProgressHUD+MJ.h"
@interface AMapCloudPOIDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary * imagesDic;
@property (nonatomic , strong) NSMutableArray * thumbPhotosUrlArray;
@property (nonatomic , strong) NSMutableArray * origPhotosUrlArray;
@end
@implementation AMapCloudPOIDetailViewController
@synthesize cloudPOI = _cloudPOI;
@synthesize tableView = _tableView;
#pragma mark - Utility
- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = nil;
        switch (indexPath.row)
        {
            case 0 : title = @"地点：";         break;
            case 1 : title = @"类型：";         break;
            case 2 : title = @"距离我：";        break;
            case 3 : title = @"电话号码：";      break;
            case 4 : title = @"所在区：";        break;
            case 5 : title = @"城市代码：";      break;
            case 6 : title = @"行政代码：";      break;
            case 7 : title = @"经纬度：";        break;
            case 8 : title = @"详细地址：";      break;
            case 9 : title = @"创建时间：";       break;
            case 10 : title = @"更新时间：";       break;
            default: break;
        }
    return title;
}
- (NSString *)subTitleForIndexPath:(NSIndexPath *)indexPath
{
    NSString *subTitle = nil;
        switch (indexPath.row)
        {
            case 0 : subTitle = self.cloudPOI.name;                                 break;
            case 1 : subTitle = [self.cloudPOI.customFields valueForKey:@"type"];
                break;
            case 2 : subTitle = [NSString stringWithFormat:@"%ld 米", (long)self.cloudPOI.distance];
                break;
            case 3 : subTitle = [self.cloudPOI.customFields valueForKey:@"telephone"];
                 break;
            case 4 : subTitle = [self.cloudPOI.customFields valueForKey:@"area"];
                 break;
            case 5 : subTitle = [self.cloudPOI.customFields valueForKey:@"citycode"];
                 break;
            case 6 : subTitle = [self.cloudPOI.customFields valueForKey:@"adcode"];
                break;
            case 7 : subTitle = [self.cloudPOI.location description];
                 break;
            case 8 : subTitle = self.cloudPOI.address;                              break;
            case 9 : subTitle = [NSString stringWithFormat:@"%@", self.cloudPOI.createTime];
                break;
            case 10 : subTitle = [NSString stringWithFormat:@"%@", self.cloudPOI.updateTime];
                break;
            default: break;
        }
    return subTitle;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *poiDetailCellIdentifier = @"cloudPOIDetailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:poiDetailCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:poiDetailCellIdentifier];
    }
    cell.textLabel.text         = [self titleForIndexPath:indexPath];
    cell.textLabel.font         = [UIFont systemFontOfSize:18];
    cell.detailTextLabel.numberOfLines = 3;
    cell.detailTextLabel.font   = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.text   = [self subTitleForIndexPath:indexPath];
    cell.accessoryType          = UITableViewCellAccessoryNone;
    cell.selectionStyle         = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
#pragma mark - Initialization
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor =  appMainColor;
    [self initWithTableFooterView];
    [self.view addSubview:self.tableView];
}
-(void)initWithTableHeaderView
{
    self.thumbPhotosUrlArray = [NSMutableArray array];
    self.origPhotosUrlArray = [NSMutableArray array];
    NSString * imageStr = [self.cloudPOI.customFields valueForKey:@"_image"];
    if (![imageStr isEqualToString:@"(\n)"])
    {
        NSArray *arry=[imageStr componentsSeparatedByString:@"}"];
        for (int i = 0;i < arry.count -1;i++)
        {
            NSString * imageStrring = arry[i];
            imageStrring = [imageStrring stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSString * preurl = (NSString *) [[[[imageStrring componentsSeparatedByString:@"preurl\"=\""] objectAtIndex:1] componentsSeparatedByString:@"\";"] objectAtIndex:0];
            [self.thumbPhotosUrlArray addObject:preurl];
            NSString * url = (NSString *) [[[[imageStrring componentsSeparatedByString:@"_url\"=\""] objectAtIndex:1] componentsSeparatedByString:@"\";"] objectAtIndex:0];
            [self.origPhotosUrlArray addObject:url];
        }
        UIButton * imageBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 300)];
        [imageBtn addTarget:self action:@selector(toPhotoBrower) forControlEvents:UIControlEventTouchUpInside];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL * url = [NSURL URLWithString:self.thumbPhotosUrlArray[0]];
            NSData * data = [[NSData alloc]initWithContentsOfURL:url];
            UIImage *image = [[UIImage alloc]initWithData:data];
            if (data != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imageBtn setImage:image forState:UIControlStateNormal];
                    self.tableView.tableHeaderView = imageBtn;
                });
            }
        });
    }
}
-(void)initWithTableFooterView
{
    NSString * detailStr = [self.cloudPOI.customFields valueForKey:@"detail"];
    if (![detailStr isEqualToString:@""])
    {
        UIView * detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 1,self.view.frame.size.width, 200)];
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(15, 0,self.view.frame.size.width - 15, 0.5)];
        line.backgroundColor = [UIColor blueColor];
        [detailView addSubview:line];
        UILabel * detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 35)];
        detailLabel.text = @"地点说明:";
        detailLabel.font = [UIFont systemFontOfSize:18];
        UITextView * detailFV = [[UITextView alloc]initWithFrame:CGRectMake(5,35,self.view.frame.size.width -10,130)];
        detailFV.layer.borderWidth = 1;
        detailFV.layer.borderColor = appMainColor.CGColor;
        detailFV.layer.cornerRadius = 3;
        detailFV.layer.masksToBounds = YES;
        detailFV.alwaysBounceVertical = YES;
        detailFV.showsVerticalScrollIndicator = YES;
        detailFV.font = [UIFont systemFontOfSize:16];
        detailFV.editable = NO;
        [detailView addSubview:detailLabel];
        [detailView addSubview:detailFV];
        dispatch_async(dispatch_get_main_queue(), ^{
            detailFV.text = [self.cloudPOI.customFields valueForKey:@"detail"];
            self.tableView.tableFooterView = detailView;
        });
    }
}
- (void)initBaseNavigationBar:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = [UIFont boldSystemFontOfSize:16];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
#warning - 多图
#pragma mark - 点击图片处理事件
-(void)toPhotoBrower
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
    PhotoBrowserController * photo = [[PhotoBrowserController alloc ]init ];
    photo.title = self.cloudPOI.name;
    photo.thumbPhotosUrlArray = self.thumbPhotosUrlArray;
    photo.origPhotosUrlArray = self.origPhotosUrlArray;
    [self.navigationController pushViewController:photo animated:YES];
}
#pragma mark - 删除地点按钮点击事件
-(void)deleteAddress
{
    [MBProgressHUD showMessage:@"正在删除中..."];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *dataAllDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                RestIKey,@"key",
                                tableID,@"tableid",
                                [NSString stringWithFormat: @"%ld",(long)self.cloudPOI.ID],@"ids",
                                nil];
    [mgr POST:@"http://yuntuapi.amap.com/datamanage/data/delete" parameters:dataAllDic
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString * status = [responseObject objectForKey:@"status"];
         if ([status intValue])
         {
             [MBProgressHUD hideHUD];
             [self.navigationController popViewControllerAnimated:YES];
             [MBProgressHUD showSuccess:@"地点删除成功"];
         }
         else
         {
             [MBProgressHUD hideHUD];
             [MBProgressHUD showError:@"数据有误，请稍后在尝试"];
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideHUD];
         [MBProgressHUD showError:@"删除失败，请重新删除"];
     }];
}
#pragma mark - 编辑按钮点击事件
-(void)toEditLocation
{
}
-(void)initWithLeftBackBtn
{
}
#pragma mark - 返回按钮点击事件
- (void)jumpBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
    [self initBaseNavigationBar:self.cloudPOI.name];
    [self initWithLeftBackBtn];
    [self initWithTableHeaderView];
    [self initWithTableFooterView];
}
@end
