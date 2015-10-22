//
//  MainModel.h
//  realmTest
//
//  Created by guozhicheng on 10/17/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "ArrayModel.h"

@interface MainModel : RLMObject

@property NSString *title;

@property RLMArray<ArrayModel *> <ArrayModel> *assets;

@property ArrayModel *model;

@property BOOL isValue;

@property NSInteger integer;

@property long long longValue;

@property double doubleValue;

@property int intValue;

@property NSData *dataValue;

@property NSDate *dateValue;

@property (nonatomic,readonly) NSInteger intengerReadonlyValue;

@end

RLM_ARRAY_TYPE(MainModel)