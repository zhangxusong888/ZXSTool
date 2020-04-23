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


#endif /* ZXSMacro_h */
