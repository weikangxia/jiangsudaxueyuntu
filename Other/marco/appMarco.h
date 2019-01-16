#ifndef GLUTCloud_appMarco_h
#define GLUTCloud_appMarco_h
const static NSString *APIKey = @"5f6741fcf341d5f41f8973728a461617";
const static NSString *RestIKey = @"d002cbe2c1fa7d862c7919f244bc57b9";
const static NSString *tableID = @"5c3ed77d305a2a1c2aaa10e1";
const static NSString *allTableID = @"5c3edbcc305a2a1c2aaad6d4";
#endif
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#define debugNSSting(a) NSLog(@"%@", a)
#else
#define debugLog(...)
#define debugMethod()
#endif
#define appMainColor [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000]
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
