//
//  ArrowListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/12.
//

import Foundation
protocol ArrowListener {
    func onLeftArrow()
    func onRightArrow()
    func onUpArrow()
    func onDownArrow()
    func onShiftLeftArrow()
    func onShiftRightArrow()
    
    func onLeftArrowFromChild(_ childModel: ArrowListener)
    func onRightArrowFromChild(_ childModel: ArrowListener)
    func onUpArrowFromChild(_ childModel: ArrowListener)
    func onDownArrowFromChild(_ childModel: ArrowListener)
    
    func setFocus(_ direction: FocusDirectionEnum)
    func loseFocus()
    
    //func replaceChild(childModel: Caretable, expressionData: ExpressionData)
    func handleDeleteFromChild(_ childModel: ArrowListener)
    
    var parentModel: ArrowListener? { get set }
    var smallerFontSize: Int { get }
    var fontSize: CGFloat { get set }
}

extension ArrowListener{
    var smallerFontSize: Int { get {return 12} }
}

