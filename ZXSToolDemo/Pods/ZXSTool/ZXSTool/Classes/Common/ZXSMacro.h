//
//  ZXSMacro.h
//  Pods
//
//  Created by zxs on 2020/4/23.
//

#ifndef ZXSMacro_h
#define ZXSMacro_h

///=============================================================================
/// 强弱引用
///=============================================================================
#define kWeakSelf(type)         __weak typeof(type) weak##type = type;
#define kStrongSelf(type)       __strong typeof(type) type = weak##type;

///=============================================================================
/// 打印日志
///=============================================================================
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

///=============================================================================
/// 颜色定义
///=============================================================================
#define kColorWithHexA(rgbValue, a)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
#define kColorWithHex(rgbValue)      kColorWithHexA(rgbValue, 1.0)

// 蓝色
#define kBlueColor                      kColorWithHex(0x4F7BFF)
// 黑色87%透明度
#define kBlackColor087                  kColorWithHexA(0x000000, 0.87)


#endif /* ZXSMacro_h */
