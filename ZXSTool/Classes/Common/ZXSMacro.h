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


#endif /* ZXSMacro_h */
