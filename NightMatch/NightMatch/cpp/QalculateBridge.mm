// QalculateBridge.mm
// Objective-C++ implementation – links against libqalculate and its deps.
#import "QalculateBridge.h"
#include "QalculateWrapper.h"
#include <cstdlib>

@implementation QalculateBridge

+ (void)initialize_qalc {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        qalc_init();
    });
}

+ (void)setPrecision:(int)precision {
    qalc_set_precision(precision);
}

+ (NSString *)evaluate:(NSString *)expr
         approximation:(int)approximation
        fractionFormat:(int)fractionFormat
             timeoutMs:(int)timeoutMs {
    char *result = qalc_calculate([expr UTF8String], approximation, fractionFormat, timeoutMs);
    NSString *str = result ? [NSString stringWithUTF8String:result] : @"(nil)";
    free(result);
    return str;
}

@end
