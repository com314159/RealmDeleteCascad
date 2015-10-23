//
//  RLMHelper.m
//  realmTest
//
//  Created by guozhicheng on 10/22/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import "RLMHelper.h"

#import "objc/runtime.h"
#import "RunTimePropertyHelper.h"

@implementation RLMHelper

+ (void) deleteModelCascad:(id)object inRealm:(RLMRealm *)realm {
    
    [self deleteModelCascad:object inRealm:realm userTransaction:YES];
    
}

+ (void) deleteModelCascad:(id)object inRealm:(RLMRealm *)realm  userTransaction:(BOOL)useTransaction {
    if (object == nil || realm == nil) {
        return ;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [RunTimePropertyHelper classPropsForClassHierarchy:[object class] onDictionary:dict];
    
    if (useTransaction) {
        [realm beginWriteTransaction];
    }
    
    for (NSString *keys in dict.allKeys) {
        
        NSString *propertyName = [dict objectForKey:keys];
        
        if (![RLMHelper isIgnoredProperty:propertyName]) {
            id value = [object valueForKey:keys];
            
            [self checkAndDeleteValue:value inRealm:realm];
        }
        
    }
    
    [realm deleteObject:object];
    
    if (useTransaction) {
        [realm commitWriteTransaction];
    }
    
}

+ (void) checkAndDeleteValue:(id)value inRealm:(RLMRealm *) realm {
    
    if ([value isKindOfClass:[RLMObject class]]) {
        
        [self deleteModelCascad:value inRealm:realm userTransaction:NO];
        
    } else if ([value isKindOfClass:[RLMArray class]]){
        
        RLMArray *array = value;
        
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (NSUInteger i=0;i<array.count; ++i) {
            id arrayValue = array[i];
            [mutableArray addObject:arrayValue];
        }
        
        for (NSUInteger i=0;i<mutableArray.count; ++i) {
            id arrayValue = mutableArray[i];
            [self checkAndDeleteValue:arrayValue inRealm:realm];
        }
    }
}

#pragma mark - ignored properties

+ (BOOL) isIgnoredProperty:(NSString *)key {
    if (key == nil) {
        return YES;
    }
    NSArray *array = [RLMHelper ignoredPropertyPrefix];
    
    for (NSUInteger i=0; i<array.count; ++i) {
        if ([key isEqualToString:array[i]]) {
            return YES;
        }
    }
    return NO;
}

+ (NSArray *) ignoredPropertyPrefix {
    return  @[@"NSInteger",@"NSString",@"NSDate",@"NSData",@"NSNumber",@"RLMObjectSchema",@"RLMRealm",
              @"B",
              @"c",
              @"d",
              @"i",
              @"f",
              @"l",
              @"s",
              @"I",
              @"q",
              ];
}


@end
