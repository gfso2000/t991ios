// QalculateWrapper.h
// Plain-C interface so Swift (via Obj-C bridge) can call libqalculate.
#pragma once
#ifdef __cplusplus
extern "C" {
#endif

// Must be called once before any other function.
void qalc_init(void);

// Free the calculator singleton. Call on app teardown (optional).
void qalc_destroy(void);

// Set precision (significant digits). Default libqalculate value is 10.
void qalc_set_precision(int precision);

// Calculate expr with the given approximation/fraction modes.
// Returns a newly malloc'd C string – caller must free() it.
//
// approximation:
//   0 = APPROXIMATION_EXACT
//   1 = APPROXIMATION_TRY_EXACT
//   2 = APPROXIMATION_APPROXIMATE
//   3 = APPROXIMATION_EXACT_VARIABLES
//
// fraction_format:
//   0 = FRACTION_DECIMAL
//   1 = FRACTION_DECIMAL_EXACT
//   2 = FRACTION_FRACTIONAL
//   3 = FRACTION_COMBINED
char *qalc_calculate(const char *expr,
                     int approximation,
                     int fraction_format,
                     int timeout_ms);

#ifdef __cplusplus
}
#endif
