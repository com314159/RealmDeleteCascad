//
//  RLMHelper.h
//  realmTest
//
//  Created by guozhicheng on 10/22/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RLMHelper : NSObject


+ (void) deleteModelCascad:(id)object inRealm:(RLMRealm *)realm;


@end
