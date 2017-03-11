//
//  DataManager.m
//  WechatOC
//
//  Created by daixianglong on 2017/3/3.
//  Copyright © 2017年 daixianglong. All rights reserved.
//

#import "DataManager.h"
#import "TimeLineModel.h"

@implementation DataManager

+(NSMutableArray *)loadDataFromJson {
    NSMutableArray *timeLineModels = [[NSMutableArray alloc]initWithCapacity:20];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
    NSData *dataJSON = [NSData dataWithContentsOfFile:path];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:dataJSON options:NSJSONReadingAllowFragments error:nil];
    //从json转换为model
    NSDictionary *data = [json valueForKey:@"data"];
    NSArray *models = [TimeLineModel mj_objectArrayWithKeyValuesArray:data[@"rows"]];
    for (TimeLineModel *model in models) {
        [timeLineModels addObject: model];
    }
    return timeLineModels;
}
@end
