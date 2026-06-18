//
//  LibQalculateUtil.swift
//  NightMatch
//

import Foundation

class LibQalculateUtil {

    static let TIMEOUT: Int32 = 60000
    static let SIXTY_PLACEHOLDER = "#sexa#"

    // MARK: - Main calculation entry point
    struct LibQalculateResult {
        let decimalResult: String
        let fractionResult: String
        let combinedFractionResult: String
    }

    static func callQalculate(_ mathExpression: String,
                               precision: Int,
                               mergeFraction: Bool = true) -> LibQalculateResult {
        var expr = replaceABCDEFxyz(mathExpression)
        expr = handleSixtyPlaceHolder(expr)

        QalculateBridge.initialize_qalc()
        QalculateBridge.setPrecision(Int32(precision))

        // APPROXIMATION_EXACT(0), FRACTION_COMBINED(3)
        var combinedFractionResult = QalculateBridge.evaluate(
            expr, approximation: 0, fractionFormat: 3, timeoutMs: TIMEOUT)

        // APPROXIMATION_EXACT(0), FRACTION_FRACTIONAL(2)
        var fractionResult = QalculateBridge.evaluate(
            expr, approximation: 0, fractionFormat: 2, timeoutMs: TIMEOUT)

        // APPROXIMATION_TRY_EXACT(1), FRACTION_DECIMAL(0)
        var decimalResult = QalculateBridge.evaluate(
            expr, approximation: 1, fractionFormat: 0, timeoutMs: TIMEOUT)

        // Strip trailing unit if present (e.g. "12.7 cm" → "12.7")
        let unit = extractUnit(decimalResult)
        if let unit = unit, unit != "i" {
            decimalResult         = decimalResult.replacingOccurrences(of: unit, with: "").trimmingCharacters(in: .whitespaces)
            fractionResult        = fractionResult.replacingOccurrences(of: unit, with: "").trimmingCharacters(in: .whitespaces)
            combinedFractionResult = combinedFractionResult.replacingOccurrences(of: unit, with: "").trimmingCharacters(in: .whitespaces)
        }

        // If fraction contains trig/hyperbolic forms or radians, fall back to decimal
        if isSinhArsinh(fractionResult) || fractionResult.contains(" rad") {
            fractionResult = decimalResult
            combinedFractionResult = decimalResult
        }

        return LibQalculateResult(decimalResult: decimalResult,
                                  fractionResult: fractionResult,
                                  combinedFractionResult: combinedFractionResult)
    }

    static func replaceABCDEFxyz(_ mathExpression: String) -> String {
        var expr = mathExpression
        let varList = VarUtil.loadVar()

        func value(for name: String) -> String {
            varList.first { $0.varName == name }
                .map { "(" + $0.getExpressionData().getDataAsQalculate() + ")" }
                ?? "(0)"
        }

        expr = expr.replacingOccurrences(of: "#varA#",   with: value(for: String(describing: SingularTextEnum.VAR_A)))
        expr = expr.replacingOccurrences(of: "#varB#",   with: value(for: String(describing: SingularTextEnum.VAR_B)))
        expr = expr.replacingOccurrences(of: "#varC#",   with: value(for: String(describing: SingularTextEnum.VAR_C)))
        expr = expr.replacingOccurrences(of: "#varD#",   with: value(for: String(describing: SingularTextEnum.VAR_D)))
        expr = expr.replacingOccurrences(of: "#varE#",   with: value(for: String(describing: SingularTextEnum.VAR_E)))
        expr = expr.replacingOccurrences(of: "#varF#",   with: value(for: String(describing: SingularTextEnum.VAR_F)))
        expr = expr.replacingOccurrences(of: "#varX#",   with: value(for: String(describing: SingularTextEnum.VAR_X)))
        expr = expr.replacingOccurrences(of: "#varY#",   with: value(for: String(describing: SingularTextEnum.VAR_Y)))
        expr = expr.replacingOccurrences(of: "#varZ#",   with: value(for: String(describing: SingularTextEnum.VAR_Z)))

        let lastAns = VarUtil.loadLastAns()
        expr = expr.replacingOccurrences(of: "#varAns#", with: "(" + lastAns.getDataAsQalculate() + ")")
        
        return expr
    }

    // MARK: - Sixty (sexagesimal) placeholder
    static func handleSixtyPlaceHolder(_ mathExpression: String) -> String {
        guard mathExpression.contains(SIXTY_PLACEHOLDER) else { return mathExpression }
        var output = ""
        let groups = mathExpression.components(separatedBy: SIXTY_PLACEHOLDER)
        for (i, group) in groups.enumerated() {
            switch i % 3 {
            case 0: output += group + "°+"
            case 1: output += group + "′+"
            default: output += group + "″"
            }
        }
        return output
    }

    // MARK: - Helpers
    static func isSinhArsinh(_ fractionResult: String) -> Bool {
        return fractionResult.contains("sinh") || fractionResult.contains("cosh") ||
               fractionResult.contains("tanh") || fractionResult.contains("arcsin") ||
               fractionResult.contains("arccos") || fractionResult.contains("arctan")
    }

    static func isFractionResultTooLong(_ fractionResult: String) -> Bool {
        let stripped = fractionResult.replacingOccurrences(of: "\\s+",
                                                           with: "",
                                                           options: .regularExpression)
        return stripped.count > 35
    }

    private static func extractUnit(_ decimalResult: String) -> String? {
        let parts = decimalResult.components(separatedBy: " ")
        guard parts.count > 1, let last = parts.last, let first = last.first else { return nil }
        if first.isLetter || first.unicodeScalars.first.map({ $0.value > 255 }) == true {
            return last
        }
        return nil
    }
}
