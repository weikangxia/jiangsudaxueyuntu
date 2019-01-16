#import "AppDelegate.h"
#import "HomeViewController.h"
#import "appMarco.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "Utility.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
#define kMALogTitle @"提示"
#define kMALogContent @"apiKey为空，请检查key是否正确设置"
        NSString *log = [NSString stringWithFormat:@"[MAMapKit] %@", kMALogContent];
        NSLog(@"%@", log);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kMALogTitle message:kMALogContent delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        });
    }
    [AMapNaviServices sharedServices].apiKey = (NSString *)APIKey;
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}
- (void)configIFlySpeech
{
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@,timeout=%@",@"53c35b10",@"20000"];
    [IFlySpeechUtility createUtility:initString];
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    application.statusBarHidden = NO;
    application.statusBarStyle = UIStatusBarStyleLightContent;
    [self configureAPIKey];
    [self configIFlySpeech];
    NSString *key = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion])
    {
        HomeViewController * homeV = [[HomeViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:homeV];
        nav.navigationBar.barTintColor = appMainColor;
        self.window.rootViewController = nav;
    }
    else
    { 
        NSUserDefaults * defaults =  [NSUserDefaults standardUserDefaults];
        NSDictionary *glutGPS = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"32.200083",@"latitude",
                                 @"119.514466",@"longitude",
                                 nil];
        [defaults setValue:glutGPS forKey:@"glutGPS"];
        if(![defaults boolForKey:@"glutSwitchIsOn"])
        {
          [defaults setBool:NO forKey:@"glutSwitchIsOn"];
        }
        if (![defaults boolForKey:@"allSwitchIsOn"])
        {
          [defaults setBool:NO forKey:@"allSwitchIsOn"];
        }
        HomeViewController * homeV = [[HomeViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:homeV];
        nav.navigationBar.barTintColor = appMainColor;
        self.window.rootViewController = nav;
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}
@end
