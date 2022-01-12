//
//  EHCategoriesMacro.h
//
//  Created by lixinxing on 15/11/27.
//  Copyright © 2016年 lixinxing All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef EHCategoriesMacro_h
#define EHCategoriesMacro_h

#ifdef __cplusplus
#define EH_EXTERN_C_BEGIN  extern "C" {
#define EH_EXTERN_C_END  }
#else
#define EH_EXTERN_C_BEGIN
#define EH_EXTERN_C_END
#endif

EH_EXTERN_C_BEGIN
//========BEGIN===========


#ifndef EH_CLAMP // return the clamped value
#define EH_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#ifndef EH_SWAP // swap two value
#define EH_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

#ifndef EH_URL    //会与stringWithFormat冲突，系统的宏定义也有同样的问题，原因不明
#define EH_URL(_URL_STRING_) [NSURL URLWithString:(_URL_STRING_)]
#endif

//检查是否为nil或者NSNull对象, 是则返回空字符串，用于避免nil或类型错误导致的crash
#ifndef EH_SAFE_STRING
#define EH_SAFE_STRING(_VALUE_)\
({\
    id tmp = (_VALUE_);\
    if (tmp == nil || [tmp isKindOfClass:[NSNull class]]) {\
        tmp = @"";\
    }\
    else{\
        tmp = tmp?:@"";\
    }\
    tmp;\
})
#endif

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 EHSYNTH_DUMMY_CLASS(NSString_EHAdd)
 */
#ifndef EHSYNTH_DUMMY_CLASS
#define EHSYNTH_DUMMY_CLASS(_name_) \
@interface EHSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation EHSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


/**
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) CGPoint myPoint;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
     EHSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
     @end
 */
#ifndef EHSYNTH_DYNAMIC_PROPERTY_CTYPE
#define EHSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (type)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif

/*
 主线程调用
 相关资料：https://github.com/rs/SDWebImage/issues/1077
 */

#ifndef dispatch_main_sync_safe
    #define dispatch_main_sync_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_sync(dispatch_get_main_queue(), block);\
    }
#endif

#ifndef dispatch_main_async_safe
    #define dispatch_main_async_safe(block)\
    if ([NSThread isMainThread]) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif

/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
    @strongify(self)
    if (!self) return;
    ...
 }];
 
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif



#define kGrayColor(value) [UIColor colorWithRed:(value)/255.0 green:(value)/255.0 blue:(value)/255.0 alpha:1.0]

#define kHexColor(value) [UIColor colorWithRed:((float)(((value) & 0xFF0000) >> 16))/255.0 green:((float)(((value) & 0xFF00) >> 8))/255.0 blue:((float)((value) & 0xFF))/255.0 alpha:1.0]
#define kHexColorWithAlpha(value, alp) [UIColor colorWithRed:((float)(((value) & 0xFF0000) >> 16))/255.0 green:((float)(((value) & 0xFF00) >> 8))/255.0 blue:((float)((value) & 0xFF))/255.0 alpha:(alp)]

/**
 *  导航栏颜色
 */
#define kThemeColor  kHexColor(0x3875F5)

#define KNavgationBarHeight 44.0f
#define kTabBarHeight 49.0f
#define kStatusBarHeight 20.0f

/*
 *  以iPhone6宽、高为标准的元单位
 */
#define kUnitWidth(width) (width*kScreenWidth/375)

#define kUnitHeight(height) (height*kScreenHeight/667)

#define kUnitFont(font) (kScreenWidth < 375 ? kUnitWidth(font) : font)

// 检查是否为nil，为nil则返回空字符串对象
#define kCheckNil(value)\
    ({id tmp;\
        if ([(value) isKindOfClass:[NSNull class]] ||\
            [[NSString stringWithFormat:@"%@",value] isEqualToString:@"(null)"] ||\
            [[NSString stringWithFormat:@"%@",value] isEqualToString:@"(NULL)"] ||\
            [[NSString stringWithFormat:@"%@",value] isEqualToString:@"null"] ||\
            [[NSString stringWithFormat:@"%@",value] isEqualToString:@"NULL"])\
            tmp = @"";\
        else\
            tmp = (value?value:@"");\
        tmp;\
    })\


// 检查字符串是否合法
#define kCheckStringLegal(obj) ((obj) && [(obj) isKindOfClass:[NSString class]])

// 检查字符串是否为空
#define kCheckStringEmpty(string) (string.length > 0 && ![string isEqualToString:@"null"] && ![string isEqualToString:@"NULL"])

//========END===========
EH_EXTERN_C_END

#endif /* EHCategoriesMacro_h */
