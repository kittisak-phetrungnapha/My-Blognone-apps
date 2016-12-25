//
//  FUSManager.h
//  Pods
//
//  Created by Kittisak Phetrungnapha on 12/16/2558 BE.
//
//

#import <Foundation/Foundation.h>

@protocol FUSManagerDelegate <NSObject>

@optional
- (void)fusAllowUserPass;          // Allow user pass when not need to update, connection fail, parse data error and etc.
- (void)fusUserDidCancel;          // User did click on button that cancels update dialog
@end

@interface FUSManager : NSObject

@property (weak, nonatomic) id<FUSManagerDelegate> delegate;
@property (strong, nonatomic) NSString *itunesId;
@property (nonatomic) BOOL debugMode;

+ (FUSManager *)sharedInstance;
- (void)checkLatestAppStoreVersion;

@end
