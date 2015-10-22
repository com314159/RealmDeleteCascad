//
//  RunTimePropertyHelper.h
//  realmTest
//
//  Created by guozhicheng on 10/22/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@interface RunTimePropertyHelper : NSObject

+ (NSDictionary *)classPropsForClassHierarchy:(Class)klass onDictionary:(NSMutableDictionary *)results;

@end
