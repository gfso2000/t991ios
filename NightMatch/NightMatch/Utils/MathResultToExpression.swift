//
//  MathResultToExpression.swift
//  NightMatch
//

import Foundation

class MathResultToExpression {

    // Convert a libqalculate result string into an ExpressionData tree.
    static func convertToExpressionData(_ calcResult: String) -> ExpressionData {
        var startId = 0
        let expressionData = doConvert(calcResult, &startId)
        convertCaretDivide(expressionData)
        return expressionData
    }

    static func convertCaretDivide(_ expressionData: ExpressionData) {
        var converted = convertCaretToSquare(&expressionData.children, startId: 0)
        while converted {
            converted = convertCaretToSquare(&expressionData.children, startId: 0)
        }
        converted = convertDivideToFraction(&expressionData.children, startId: 0)
        while converted {
            converted = convertDivideToFraction(&expressionData.children, startId: 0)
        }
    }

    // MARK: - Private

    private static func doConvert(_ calcResult: String, _ startId: inout Int) -> ExpressionData {
        var children: [ExpressionItemData] = []
        startId += 1
        let expressionData = ExpressionData(lastFocusedChildrenId: -1, children: children, id: startId)

        let chars = Array(calcResult)
        var i = 0
        while i < chars.count {
            if chars[i] == " " { i += 1; continue }

            let sub = String(chars[i...])

            // Engineering symbols
            let engBefore = i
            i = handleEngineeringSymbol(calcResult, i, &children, &startId)
            if i != engBefore { i += 1; continue }

            // sin/cos/tan/arc* functions
            let sinBefore = i
            i = handleSinCos(calcResult, i, &children, &startId)
            if i != sinBefore { i += 1; continue }

            // pi
            if chars[i] == "p" && sub.hasPrefix("pi") {
                startId += 1
                children.append(SingularTextData(id: startId, text: .PI))
                i += 2; continue
            }
            // sqrt(
            if chars[i] == "s" && sub.hasPrefix("sqrt(") {
                let innerStart = i + 5
                guard let rp = findRightParenthesis(calcResult, innerStart) else { i += 1; continue }
                var sid = startId
                let inner = doConvert(String(chars[innerStart..<rp]), &sid)
                startId = sid + 1
                children.append(SquareRootData(innerPartData: inner, id: startId))
                i = rp + 1; continue
            }
            // cbrt(
            if chars[i] == "c" && sub.hasPrefix("cbrt(") {
                let innerStart = i + 5
                guard let rp = findRightParenthesis(calcResult, innerStart) else { i += 1; continue }
                var sid = startId
                let inner = doConvert(String(chars[innerStart..<rp]), &sid)
                startId = sid + 1
                let outer = ExpressionData(lastFocusedChildrenId: -1,
                                           children: [SingularTextData(id: startId + 1, text: .THREE)],
                                           id: startId + 2)
                startId += 3
                children.append(MixedSquareRootData(outerPartData: outer, innerPartData: inner, id: startId))
                i = rp + 1; continue
            }
            // ln(
            if chars[i] == "l" && sub.hasPrefix("ln(") {
                let innerStart = i + 3
                guard let rp = findRightParenthesis(calcResult, innerStart) else { i += 1; continue }
                var sid = startId
                let inner = doConvert(String(chars[innerStart..<rp]), &sid)
                startId = sid + 1
                children.append(LogSimpleData(innerPartData: inner, id: startId, type: "ln"))
                i = rp + 1; continue
            }

            // digits
            if chars[i] == "." {
                startId += 1; children.append(SingularTextData(id: startId, text: .DOT))
                i += 1; continue
            }
            if let d = digitEnum(chars[i]) {
                startId += 1; children.append(SingularTextData(id: startId, text: d))
                i += 1; continue
            }

            // operators and special chars
            startId += 1
            switch chars[i] {
            case "*": children.append(SingularTextData(id: startId, text: .MULTIPLY))
            case "/": children.append(SingularTextData(id: startId, text: .DIVIDE))
            case "+": children.append(SingularTextData(id: startId, text: .ADD))
            case "-": children.append(SingularTextData(id: startId, text: .SUBTRACT))
            case "(": children.append(SingularTextData(id: startId, text: .LEFT_PARENTHESIS))
            case ")": children.append(SingularTextData(id: startId, text: .RIGHT_PARENTHESIS))
            case "x": children.append(SingularTextData(id: startId, text: .VAR_X))
            case "e": children.append(SingularTextData(id: startId, text: .CONST_E))
            case "^": children.append(SingularTextData(id: startId, text: .CARET))
            case "E": children.append(SingularTextData(id: startId, text: .SCI_E))
            case "i": children.append(SingularTextData(id: startId, text: .COMPLEX_I))
            default: startId -= 1   // unrecognised — don't advance id
            }
            i += 1
        }

        expressionData.children = children
        return expressionData
    }

    // Returns new index (unchanged if no match).
    private static func handleEngineeringSymbol(_ s: String, _ i: Int, _ children: inout [ExpressionItemData], _ startId: inout Int) -> Int {
        let sub = String(s.dropFirst(i))
        let pairs: [(String, SingularTextEnum)] = [
            ("femto", .NEGATIVE), ("pico", .NEGATIVE), ("nano", .NEGATIVE),
            ("micro", .NEGATIVE), ("milli", .NEGATIVE), ("kilo", .NEGATIVE),
            ("mega", .NEGATIVE), ("giga", .NEGATIVE), ("tera", .NEGATIVE),
            ("peta", .NEGATIVE), ("exa", .NEGATIVE),
        ]
        // Only the engineering symbols we have in SingularTextEnum are mapped;
        // others are skipped (they don't exist in the iOS enum yet).
        let engMap: [(String, SingularTextEnum)] = [
            ("femto", .NEGATIVE),   // placeholder — ENG_ cases not in iOS enum; skip
        ]
        _ = pairs; _ = engMap
        // Currently SingularTextEnum has no ENG_ cases — return unchanged.
        return i
    }

    private static func handleSinCos(_ s: String, _ i: Int, _ children: inout [ExpressionItemData], _ startId: inout Int) -> Int {
        let types = ["arcsinh","arccosh","arctanh","arcsin","arccos","arctan","sinh","cosh","tanh","sin","cos","tan"]
        let chars = Array(s)
        let sub = String(chars[i...])
        for type in types {
            if sub.hasPrefix(type + "(") {
                let innerStart = i + type.count + 1
                guard let rp = findRightParenthesis(s, innerStart) else { continue }
                var sid = startId
                let inner = doConvert(String(chars[innerStart..<rp]), &sid)
                startId = sid + 1
                children.append(MethodOneData(innerPartData: inner, id: startId, type: type))
                return rp    // caller does i = result + 1
            }
        }
        return i
    }

    // MARK: - Caret → Square

    private static func convertCaretToSquare(_ children: inout [ExpressionItemData], startId: Int) -> Bool {
        guard let caretIdx = findCaretIndex(children) else { return false }
        var startId = startId

        var bottomChildren: [ExpressionItemData] = []
        var startPos = caretIdx
        let prevQalc = children[caretIdx - 1].getDataAsQalculate()
        if prevQalc == ")" {
            startPos = findLeftParenthesisIndex(children, caretIdx - 2)
        } else if isE(children[caretIdx - 1]) || isX(children[caretIdx - 1]) || isPI(children[caretIdx - 1]) {
            startPos = caretIdx - 1
        } else {
            var s = caretIdx - 1
            while s > 0 && isNumberOrSqrt(children[s - 1]) { s -= 1 }
            startPos = s < caretIdx ? s : caretIdx - 1
            if !isNumberOrSqrt(children[startPos]) { startPos = caretIdx - 1 }
            // walk back to find start of consecutive number/sqrt run
            startPos = caretIdx - 1
            var s2 = caretIdx - 1
            while s2 >= 0 && isNumberOrSqrt(children[s2]) { s2 -= 1 }
            startPos = s2 + 1
            if startPos > caretIdx - 1 { startPos = caretIdx - 1 }
        }
        for j in startPos..<caretIdx { bottomChildren.append(children[j]) }

        var topChildren: [ExpressionItemData] = []
        var endPos = caretIdx
        let nextQalc = children[caretIdx + 1].getDataAsQalculate()
        if nextQalc == "(" {
            endPos = findRightParenthesisIndex(children, caretIdx + 2)
        } else if isE(children[caretIdx + 1]) || isX(children[caretIdx + 1]) || isPI(children[caretIdx + 1]) {
            endPos = caretIdx + 1
        } else {
            var e = caretIdx + 1
            while e < children.count && isNumberOrSqrt(children[e]) { e += 1 }
            endPos = e - 1
            if endPos < caretIdx + 1 { endPos = caretIdx + 1 }
        }
        for j in (caretIdx + 1)...endPos { topChildren.append(children[j]) }

        // remove startPos...endPos
        children.removeSubrange(startPos...endPos)

        startId += 1
        let bottomData = ExpressionData(lastFocusedChildrenId: -1, children: bottomChildren, id: startId)
        startId += 1
        let topData = ExpressionData(lastFocusedChildrenId: -1, children: topChildren, id: startId)
        startId += 1

        convertCaretDivide(bottomData)
        convertCaretDivide(topData)
        children.insert(SquareData(bottomPartData: bottomData, topPartData: topData, id: startId), at: startPos)
        return true
    }

    // MARK: - Divide → Fraction

    private static func convertDivideToFraction(_ children: inout [ExpressionItemData], startId: Int) -> Bool {
        guard let divIdx = findDivideIndex(children) else { return false }
        var startId = startId

        var numChildren: [ExpressionItemData] = []
        var startPos = divIdx
        let prevQalc = children[divIdx - 1].getDataAsQalculate()
        if prevQalc == ")" {
            startPos = findLeftParenthesisIndex(children, divIdx - 2)
        } else {
            var s = divIdx - 1
            while s >= 0 && (isNumberOrSqrt(children[s]) || isPI(children[s])) { s -= 1 }
            startPos = s + 1
            if startPos > divIdx - 1 { startPos = divIdx - 1 }
        }
        for j in startPos..<divIdx { numChildren.append(children[j]) }

        var denChildren: [ExpressionItemData] = []
        var endPos = divIdx
        let nextQalc = children[divIdx + 1].getDataAsQalculate()
        if nextQalc == "(" {
            endPos = findRightParenthesisIndex(children, divIdx + 2)
        } else {
            var e = divIdx + 1
            while e < children.count && (isNumberOrSqrt(children[e]) || isPI(children[e])) { e += 1 }
            endPos = e - 1
            if endPos < divIdx + 1 { endPos = divIdx + 1 }
        }
        for j in (divIdx + 1)...endPos { denChildren.append(children[j]) }

        children.removeSubrange(startPos...endPos)

        startId += 1
        let numData = ExpressionData(lastFocusedChildrenId: -1, children: numChildren, id: startId)
        startId += 1
        let denData = ExpressionData(lastFocusedChildrenId: -1, children: denChildren, id: startId)
        startId += 1

        convertCaretDivide(numData)
        convertCaretDivide(denData)
        children.insert(FractionData(numeratorPartData: numData, denominatorPartData: denData, id: startId), at: startPos)
        return true
    }

    // MARK: - Helpers

    private static func digitEnum(_ c: Character) -> SingularTextEnum? {
        switch c {
        case "0": return .ZERO
        case "1": return .ONE
        case "2": return .TWO
        case "3": return .THREE
        case "4": return .FOUR
        case "5": return .FIVE
        case "6": return .SIX
        case "7": return .SEVEN
        case "8": return .EIGHT
        case "9": return .NINE
        default: return nil
        }
    }

    private static func findRightParenthesis(_ s: String, _ startIndex: Int) -> Int? {
        let chars = Array(s)
        var depth = 1
        var i = startIndex
        while i < chars.count {
            if chars[i] == "(" { depth += 1 }
            else if chars[i] == ")" { depth -= 1 }
            if depth == 0 { return i }
            i += 1
        }
        return nil
    }

    private static func findCaretIndex(_ children: [ExpressionItemData]) -> Int? {
        for (i, child) in children.enumerated() {
            if let st = child as? SingularTextData, st.text == .CARET { return i }
        }
        return nil
    }

    private static func findDivideIndex(_ children: [ExpressionItemData]) -> Int? {
        for (i, child) in children.enumerated() {
            if let st = child as? SingularTextData, st.text == .DIVIDE { return i }
        }
        return nil
    }

    private static func findLeftParenthesisIndex(_ children: [ExpressionItemData], _ startIndex: Int) -> Int {
        var depth = 1
        var i = startIndex
        while i >= 0 && depth > 0 {
            let q = children[i].getDataAsQalculate()
            if q == ")" { depth += 1 }
            else if q == "(" { depth -= 1 }
            if depth == 0 { return i }
            i -= 1
        }
        return 0
    }

    private static func findRightParenthesisIndex(_ children: [ExpressionItemData], _ startIndex: Int) -> Int {
        var depth = 1
        var i = startIndex
        while i < children.count && depth > 0 {
            let q = children[i].getDataAsQalculate()
            if q == "(" { depth += 1 }
            else if q == ")" { depth -= 1 }
            if depth == 0 { return i }
            i += 1
        }
        return children.count - 1
    }

    private static func isNumberOrSqrt(_ child: ExpressionItemData) -> Bool {
        if child is SquareRootData || child is MixedSquareRootData ||
           child is SquareData || child is LogSimpleData || child is LogFullData {
            return true
        }
        if let st = child as? SingularTextData {
            return "0123456789πE".contains(st.text.rawValue)
        }
        return false
    }

    private static func isX(_ child: ExpressionItemData) -> Bool {
        (child as? SingularTextData)?.text == .VAR_X
    }
    private static func isE(_ child: ExpressionItemData) -> Bool {
        (child as? SingularTextData)?.text == .CONST_E
    }
    private static func isPI(_ child: ExpressionItemData) -> Bool {
        (child as? SingularTextData)?.text == .PI
    }
}
