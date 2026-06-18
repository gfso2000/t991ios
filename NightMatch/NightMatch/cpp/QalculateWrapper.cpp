// QalculateWrapper.cpp
// Thin C++ implementation of the plain-C API wrapping libqalculate.
#include "QalculateWrapper.h"
#include <libqalculate/qalculate.h>
#include <cstring>
#include <cstdlib>
#include <string>

static Calculator *s_calc = nullptr;

void qalc_init(void) {
    if (s_calc) return;
    s_calc = new Calculator();
    s_calc->loadGlobalDefinitions();
    s_calc->loadLocalDefinitions();
}

void qalc_destroy(void) {
    delete s_calc;
    s_calc = nullptr;
}

void qalc_set_precision(int precision) {
    if (s_calc) s_calc->setPrecision(precision);
}

static ApproximationMode to_approx(int v) {
    switch (v) {
        case 0: return APPROXIMATION_EXACT;
        case 1: return APPROXIMATION_TRY_EXACT;
        case 2: return APPROXIMATION_APPROXIMATE;
        case 3: return APPROXIMATION_EXACT_VARIABLES;
        default: return APPROXIMATION_TRY_EXACT;
    }
}

static NumberFractionFormat to_fraction(int v) {
    switch (v) {
        case 0: return FRACTION_DECIMAL;
        case 1: return FRACTION_DECIMAL_EXACT;
        case 2: return FRACTION_FRACTIONAL;
        case 3: return FRACTION_COMBINED;
        default: return FRACTION_DECIMAL;
    }
}

char *qalc_calculate(const char *expr,
                     int approximation,
                     int fraction_format,
                     int timeout_ms) {
    if (!s_calc || !expr) {
        return strdup("(error: not initialised)");
    }

    EvaluationOptions eo;
    eo.approximation = to_approx(approximation);

    PrintOptions po;
    po.number_fraction_format = to_fraction(fraction_format);

    std::string result = s_calc->calculateAndPrint(
        std::string(expr), timeout_ms, eo, po);

    return strdup(result.c_str());   // caller must free()
}
