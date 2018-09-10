//
//  AFNTool.h
//
//  Created by 小华 on 2018/8/17.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class RequestDataModel;

@interface AFNTool : NSObject

+(void)postWithURl:(NSString *)url parameters:(NSDictionary *)parames success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)getWithURl:(NSString *)url parameters:(NSDictionary *)parames success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

+(void)reqGetWithURl:(NSString *)url
          parameters:(RequestDataModel *)model
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSError *error))failure;

@end

@interface RequestDataModel : NSObject

@property(nonatomic,copy)NSString *city;

@end
