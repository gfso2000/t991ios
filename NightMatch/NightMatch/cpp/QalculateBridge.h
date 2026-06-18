// QalculateBridge.h
// Objective-C class that wraps QalculateWrapper.h for use from Swift.
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QalculateBridge : NSObject

// Call once at app launch (e.g. in AppDelegate / App.init).
+ (void)initialize_qalc;

// Set precision (significant digits). Default is 10.
+ (void)setPrecision:(int)precision;

// Single calculation with explicit approximation + fraction format.
// approximation: 0=EXACT 1=TRY_EXACT 2=APPROXIMATE 3=EXACT_VARIABLES
// fractionFormat: 0=DECIMAL 1=DECIMAL_EXACT 2=FRACTIONAL 3=COMBINED
+ (NSString *)evaluate:(NSString *)expr
         approximation:(int)approximation
        fractionFormat:(int)fractionFormat
             timeoutMs:(int)timeoutMs;

@end

NS_ASSUME_NONNULL_END
