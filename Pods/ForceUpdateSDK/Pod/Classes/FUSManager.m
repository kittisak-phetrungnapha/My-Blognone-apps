//
//  FUSManager.m
//  Pods
//
//  Created by Kittisak Phetrungnapha on 12/16/2558 BE.
//
//

#define FUS_APP_VERSION     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define FUS_API_ACCESSBLOCKING(itunesId)         [NSString stringWithFormat:@"https://mlib.eggdigital.com/accessblocking/check.php?id=%@&version=%@&os=ios", itunesId, FUS_APP_VERSION]
#define FUS_iTunesStringUrl(itunesId) [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", itunesId]

#define FUS_ACCESS_BLOCKING_JSON_DICT_CACHE_KEY(itunesId)     [NSString stringWithFormat:@"fus_access_blocking_json_dict_cache_key/id%@/v%@", itunesId, FUS_APP_VERSION]

#define FUS_FORCE_UPDATE_ALERT_TAG      100
#define FUS_OPTIONAL_UPDATE_ALERT_TAG   200

#import "FUSManager.h"

@interface FUSManager () <UIAlertViewDelegate> {
    NSString *alert_message;
    NSString *forceUpdate;
    BOOL alertIsShown;
}

@end

@implementation FUSManager

+ (FUSManager *)sharedInstance
{
    static FUSManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FUSManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)checkLatestAppStoreVersion
{
    if (alertIsShown) {
        if (self.debugMode) {
            NSLog(@"[FUS] AlertView is already being shown.");
        }
        return ;
    }
    
    // Check cache dict
    NSDictionary *cacheDict = [self getCache:FUS_ACCESS_BLOCKING_JSON_DICT_CACHE_KEY(self.itunesId)];
    if (self.debugMode) {
        NSLog(@"[FUS] Cache key = %@", FUS_ACCESS_BLOCKING_JSON_DICT_CACHE_KEY(self.itunesId));
    }
    
    if (cacheDict != nil) {
        NSString *expire_timestamp = [cacheDict objectForKey:@"timestamp"];
        
        // Check expire timestamp
        if ([self isExpireWithTimestamp:expire_timestamp]) { // Load new data
            [self loadNewData];
        }
        else { // Use cache data
            [self parseDataWithDict:cacheDict];
        }
    }
    else { // First time to load data
        [self loadNewData];
    }
}

- (void)loadNewData
{
    // Check itunes id must have
    if (self.itunesId == nil || [@"" isEqualToString:self.itunesId]) {
        NSLog(@"[FUS] You need to set itunes id.");
        
        [self allowUserPassInAppFromAsyncThread:NO];
        return ;
    }
    
    // Create urlString for API request
    NSString *apiString = FUS_API_ACCESSBLOCKING(self.itunesId);
    apiString = [apiString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // Initialize apiURL with apiString, and create request object
    NSURL *apiURL = [NSURL URLWithString:apiString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:apiURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod:@"GET"];
    
    if (self.debugMode) {
        NSLog(@"[FUS] Request url string = %@", apiString);
    }
    
    // Create task for download
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (data.length > 0 && error == nil) { // Success
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (self.debugMode) {
                NSLog(@"[FUS] JSON Result = %@", appData);
            }
            
            // Check response from server
            if (appData == nil) { // Invalid data
                [self allowUserPassInAppFromAsyncThread:YES];
                return ;
            }
            
            // Save success data for caching next time.
            [self setCache:appData key:FUS_ACCESS_BLOCKING_JSON_DICT_CACHE_KEY(self.itunesId)];
            
            // Parse data
            dispatch_async(dispatch_get_main_queue(), ^{
                [self parseDataWithDict:appData];
            });
        }
        else { // Fail
            if (self.debugMode && error != nil) {
                NSLog(@"[FUS] Error: %@", error.localizedDescription);
            }
            
            [self allowUserPassInAppFromAsyncThread:YES];
        }
    }];
    // Start task
    [task resume];
}

- (void)allowUserPassInAppFromAsyncThread:(BOOL)fromAsyncThread
{
    if (fromAsyncThread) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // Also allow user pass in app.
            if ([self.delegate respondsToSelector:@selector(fusAllowUserPass)]) {
                [self.delegate fusAllowUserPass];
            }
        });
    }
    else {
        // Also allow user pass in app.
        if ([self.delegate respondsToSelector:@selector(fusAllowUserPass)]) {
            [self.delegate fusAllowUserPass];
        }
    }
}

- (void)parseDataWithDict:(NSDictionary *)dict
{
    @try {
        // Check status code
        NSInteger statusCode = [[dict objectForKey:@"statusCode"] integerValue];
        if (statusCode != 200) { // Found error on success data
            [self allowUserPassInAppFromAsyncThread:NO];
            return ;
        }
        
        // Prepare alert message
        NSString *appStoreVersion = [dict objectForKey:@"softwareVersion"];
        NSString *whatNewMsg = [dict objectForKey:@"recentChange"];
        
        if (appStoreVersion == nil || [@"" isEqualToString:appStoreVersion] ||
            whatNewMsg == nil || [@"" isEqualToString:whatNewMsg]) {
            alert_message = @"Update new version available.";
        }
        else {
            alert_message = [NSString stringWithFormat:@"Version: %@\n\nWhat's new:\n%@", appStoreVersion, whatNewMsg];
        }
        
        forceUpdate = [dict objectForKey:@"forceUpdate"];
        if (forceUpdate != nil && ![@"" isEqualToString:forceUpdate]) {
            forceUpdate = [forceUpdate lowercaseString];
        }
        
        // Check force update
        [self makeDecision];
    }
    @catch (NSException *exception) {
        alert_message = nil;
        forceUpdate = nil;
        [self allowUserPassInAppFromAsyncThread:NO];
    }
}

- (void)makeDecision
{
    if (alertIsShown) {
        if (self.debugMode) {
            NSLog(@"[FUS] AlertView is already being shown.");
        }
        return ;
    }
    
    if ([@"yes" isEqualToString:forceUpdate]) { // Force update
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Available" message:alert_message delegate:self cancelButtonTitle:@"Update" otherButtonTitles:nil];
        alert.tag = FUS_FORCE_UPDATE_ALERT_TAG;
        [alert show];
        alertIsShown = YES;
    }
    else if ([@"optional" isEqualToString:forceUpdate]) { // Optional update
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Update Available" message:alert_message delegate:self cancelButtonTitle:@"Update" otherButtonTitles:@"Later", nil];
        alert.tag = FUS_OPTIONAL_UPDATE_ALERT_TAG;
        [alert show];
        alertIsShown = YES;
    }
    else { // No update or forceUpdate is Null.
        [self allowUserPassInAppFromAsyncThread:NO];
    }
}

- (void)launchAppStore
{
    NSURL *iTunesURL = [NSURL URLWithString:FUS_iTunesStringUrl(self.itunesId)];
    [[UIApplication sharedApplication] openURL:iTunesURL];
    exit(0);
}

#pragma mark - Caching method
- (void)setCache:(NSDictionary *)dataDict key:(NSString *)key;
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataDict];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)getCache:(NSString *)key
{
    @try {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (data) {
            NSDictionary *dict = (NSDictionary *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            return dict;
        }
        else {
            return nil;
        }
    }
    @catch (NSException *exception) {
        return nil;
    }
}

- (BOOL)isExpireWithTimestamp:(NSString *)expireTimestamp
{
    if (!expireTimestamp) {
        return YES;
    }
    
    unsigned long currentTime = (unsigned long)[[NSDate date] timeIntervalSince1970];
    unsigned long expireTime = (unsigned long)[expireTimestamp longLongValue];
    if (currentTime >= expireTime) {
        return YES;
    }
    else {
        return NO;
    }
}

#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    alertIsShown = NO;
    
    if (alertView.tag == FUS_FORCE_UPDATE_ALERT_TAG) { // Launch to Appstore.app
        [self launchAppStore];
    }
    else if (alertView.tag == FUS_OPTIONAL_UPDATE_ALERT_TAG) {
        if (buttonIndex == 0) { // Launch to Appstore.app
            [self launchAppStore];
        }
        else { // User clicks later button.
            if ([self.delegate respondsToSelector:@selector(fusUserDidCancel)]) {
                [self.delegate fusUserDidCancel];
            }
        }
    }
}

@end
