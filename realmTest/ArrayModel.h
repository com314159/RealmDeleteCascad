//
//  ArrayModel.h
//  realmTest
//
//  Created by guozhicheng on 10/17/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "LastModel.h"

@interface ArrayModel : RLMObject

@property (nonatomic) NSString *arrayValue;

@property (nonatomic) LastModel *otherModel;

@end

RLM_ARRAY_TYPE(ArrayModel)