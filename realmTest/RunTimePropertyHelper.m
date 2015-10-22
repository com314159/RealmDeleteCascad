//
//  RunTimePropertyHelper.m
//  realmTest
//
//  Created by guozhicheng on 10/22/15.
//  Copyright © 2015 guozhicheng. All rights reserved.
//

#import "RunTimePropertyHelper.h"

#import "objc/runtime.h"

@implementation RunTimePropertyHelper


+ (NSDictionary *)classPropsForClassHierarchy:(Class)klass onDictionary:(NSMutableDictionary *)results
{
    if (klass == NULL) {
        return nil;
    }
    
    if (klass == [NSObject class]) {
        return [NSDictionary dictionaryWithDictionary:results];
    }
    else{
        
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList(klass, &outCount);
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            const char *propName = property_getName(property);
            const char *propType = getPropertyType(property);
            if(propName && propType) {
                NSString *propertyName = [NSString stringWithUTF8String:propName];
                NSString *propertyType = [NSString stringWithUTF8String:propType];
                [results setObject:propertyType forKey:propertyName];
            }
        }
        free(properties);
        
        //go for the superclass
        return [self classPropsForClassHierarchy:[klass superclass] onDictionary:results];
        
    }
}


static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // A C primitive type:
            /*
             For example, int "i", long "l", unsigned "I", struct.
             Apple docs list plenty of examples of values returned. For a list
             of what will be returned for these primitives, search online for
             "Objective-c" "Property Attribute Description Examples"
             */
            NSString *name = [[NSString alloc] initWithBytes:attribute + 1 length:strlen(attribute) - 1 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // An Objective C id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // Another Objective C id type:
            NSString *name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end
