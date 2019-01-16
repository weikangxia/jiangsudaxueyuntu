#import "SettingViewController.h"
#import "appMarco.h"
#import "AbutGLUTCloudViewController.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD+MJ.h"
#import "TCAppViewController.h"
#import "TCHelpViewController.h"
#import <StoreKit/StoreKit.h>
#import <SafariServices/SafariServices.h>
@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation SettingViewController
@synthesize tableView = _tableView;
#pragma mark - Utility
- (NSString *)titleForIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = nil;
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0 : title = @"江苏大学云图定位";    break;
            default:    break;
        }
    }
    else if(indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0   : title = @"全部云图定位";            break;
            default  :  break;
        }
    }
    else
    {
        switch (indexPath.row)
        {
            case 0   : title = @"使用帮助";            break;
            case 1   : title = @"意见反馈";            break;
            case 2   : title = @"作者博客";            break;
            case 3   : title = @"隐私政策";            break;
            case 4   : title = @"关于应用";            break;
            default  :  break;
        }
    }
    return title;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        section = 1;
    }
    else if(section  == 1)
    {
        section = 1;
    }
    else
    {
        section = 5;
    }
    return section;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * headerTitle;
    if(section == 0)
    {
        headerTitle = @"是否使用自己的位置作为江苏大学云图的地图中心点（默认以江苏大学GPS为中心）";
    }
    else if(section  == 1)
    {
        headerTitle =  @"是否使用自己的位置作为全部云图的地图中心点（默认以江苏大学GPS为中心）";
    }
    else
    {
        headerTitle =  @"江苏大学云图";
    }
    return headerTitle;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *poiDetailCellIdentifier = @"poiDetailCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:poiDetailCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:poiDetailCellIdentifier];
    }
    cell.textLabel.text         = [self titleForIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if ([cell.textLabel.text isEqualToString:@"江苏大学云图定位"])
    {
        UISwitch * locationSwitch = [[UISwitch alloc]init];
        locationSwitch.onTintColor = [UIColor colorWithRed:0.186 green:0.744 blue:1.000 alpha:1.000];
        locationSwitch.tintColor = [UIColor lightGrayColor];
        [locationSwitch addTarget:self action:@selector(settingSwith:) forControlEvents:UIControlEventValueChanged];
        locationSwitch.tag =1;
        NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
        if([defaults boolForKey:@"glutSwitchIsOn"])
        {
            [locationSwitch setOn:YES];
        }
        cell.accessoryView = locationSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else if([cell.textLabel.text isEqualToString:@"全部云图定位"])
    {
        UISwitch * locationSwitch = [[UISwitch alloc]init];
        locationSwitch.onTintColor = [UIColor colorWithRed:0.186 green:0.744 blue:1.000 alpha:1.000];
        locationSwitch.tintColor = [UIColor lightGrayColor];
        [locationSwitch addTarget:self action:@selector(settingSwith:) forControlEvents:UIControlEventValueChanged];
        locationSwitch.tag =2;
        NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
        if ([defaults boolForKey:@"allSwitchIsOn"])
        {
            [locationSwitch setOn:YES];
        }
        cell.accessoryView = locationSwitch;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
 if ([cell.textLabel.text isEqualToString:@"关于应用"])
    {
        [self initbackItem];
        AbutGLUTCloudViewController * abut = [[AbutGLUTCloudViewController alloc]init];
        [self.navigationController pushViewController:abut animated:YES];
    }
    else if ([cell.textLabel.text isEqualToString:@"意见反馈"])
    {
        [self sendFeedback];
    }
    else if([cell.textLabel.text isEqualToString:@"使用帮助"])
    {
        [self initbackItem];
        TCHelpViewController * help = [[TCHelpViewController alloc]init];
        [self.navigationController pushViewController:help animated:YES];
    }
    else if([cell.textLabel.text isEqualToString:@"作者博客"])
    {
        [self inSafariOpenWithURL:@"https://github.com/weikangxia"];
    }
    else if([cell.textLabel.text isEqualToString:@"隐私政策"])
    {
        [self inSafariOpenWithURL:@"https://github.com/weikangxia/jiangsudaxueyuntu/blob/master/jiangsudaxuePrivacyPolicy"];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)inSafariOpenWithURL:(NSString *)url
{
    if (@available(iOS 9.0, *)) {
        SFSafariViewController * sf = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        if (@available(iOS 11.0, *)) {
            sf.preferredBarTintColor = [UIColor colorWithRed:(66)/255.0 green:(156)/255.0 blue:(249)/255.0 alpha:1];
            sf.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleClose;
        }
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:sf animated:YES completion:nil];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}
#pragma mark - 意见反馈
-(void)sendFeedback
{
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
    [mail setSubject:@"使用江苏大学云图的意见反馈"];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString * messBody = [NSString stringWithFormat:@"我当前使用的云图版本是:%@, %@,OS%@\n我的建议：",[infoDictionary objectForKey:@"CFBundleShortVersionString"],[[UIDevice currentDevice] model],[[UIDevice currentDevice] systemVersion]];
    [mail setMessageBody:messBody isHTML:NO];
    [mail setToRecipients:@[@"dsu806@163.com"]];
    mail.mailComposeDelegate = self;
    [self presentViewController:mail animated:YES completion:nil];
}
#pragma mark - 按钮处理事件
-(void)settingSwith:(UISwitch *)settingSwith
{
    NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
    if (settingSwith.tag == 1)
    {
        if (settingSwith.isOn)
        {
            [defaults setBool:YES forKey:@"glutSwitchIsOn"];
        }
        else
        {
           [defaults setBool:NO forKey:@"glutSwitchIsOn"];
        }
    }
    else
    {
        if (settingSwith.isOn)
        {
            [defaults setBool:YES forKey:@"allSwitchIsOn"];
        }
        else
        {
            [defaults setBool:NO forKey:@"allSwitchIsOn"];
        }
    }
}
#pragma mark - Initialization
- (void)initbackItem
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backItem;
}
- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)initTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor  = [UIColor clearColor];
    titleLabel.textColor        = [UIColor whiteColor];
    titleLabel.font             = [UIFont boldSystemFontOfSize:16];
    titleLabel.text             = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitle:@"应用设置"];
    [self initTableView];
}
#pragma mark - send Email
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled)
    {
        [MBProgressHUD showSuccess:@"已取消发送"];
    }
    else if (result == MessageComposeResultSent)
    {
        [MBProgressHUD showSuccess:@"发送成功"];
    } else
    {
        [MBProgressHUD showError:@"发送失败"];
    }
    [self performSelector:@selector(didhideHUD) withObject:nil afterDelay:1.0];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MFMailComposeResultCancelled)
    {
        [MBRoundProgressView setAnimationDelay:1];
        [MBProgressHUD showSuccess:@"已取消发送"];
    } else if (result == MFMailComposeResultSent)
    {
        [MBProgressHUD showSuccess:@"发送成功"];
    } else
    {
        [MBProgressHUD showError:@"发送失败"];
    }
    [self performSelector:@selector(didhideHUD) withObject:nil afterDelay:1.0];
}
-(void)didhideHUD
{
    [MBProgressHUD hideHUD];
}
@end
