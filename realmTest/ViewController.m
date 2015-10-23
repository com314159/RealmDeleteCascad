//
//  ViewController.m
//  realmTest
//
//  Created by guozhicheng on 10/17/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import "ViewController.h"
#import "MainModel.h"
#import "ArrayModel.h"
#import <Realm/Realm.h>
#import "RLMHelper.h"
#import "LastModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self generateDataAndDelete];
    
    
}


- (void) generateDataAndDelete {
    MainModel *model = [[MainModel alloc] init];
    model.title = @"test1";
    
    model.dataValue = [NSData data];
    model.dateValue = [NSDate date];
    
    
    ArrayModel *arrayModel = [[ArrayModel alloc] init];
    arrayModel.arrayValue = @"test";
    arrayModel.otherModel = [[LastModel alloc] init];
    
    ArrayModel *arrayModel1 = [[ArrayModel alloc] init];
    arrayModel1.arrayValue = @"test2";
    arrayModel1.otherModel = [[LastModel alloc] init];
    
    
    ArrayModel *arrayModel2 = [[ArrayModel alloc] init];
    arrayModel2.arrayValue = @"test2";
    arrayModel2.otherModel = [[LastModel alloc] init];
    
    ArrayModel *arrayModel3 = [[ArrayModel alloc] init];
    arrayModel2.arrayValue = @"test2";
    arrayModel2.otherModel = [[LastModel alloc] init];
    
    [model.assets addObject:arrayModel];
    [model.assets addObject:arrayModel2];
    [model.assets addObject:arrayModel3];
    model.model = arrayModel1;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    [realm addObject:model];
    
    [realm commitWriteTransaction];
    
    
    [RLMHelper deleteModelCascad:model inRealm:realm];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
