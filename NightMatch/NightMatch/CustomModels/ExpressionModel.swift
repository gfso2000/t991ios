//
//  ExpressionModel.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/8/9.
//

import Foundation

class ExpressionModel:ObservableObject,ArrowListener{
    var expressionContext:ExpressionContext?
    var parentModel: ArrowListener?
    var fontSize: CGFloat
    var id: Int
    var endCharTextModel: SingularTextModel
    @Published var children:[Caretable] = []
    @Published var lastFocusedChildrenId:Int = -1
    
    init(expressionContext:ExpressionContext?,id:Int, parentModel: ArrowListener? = nil, fontSize: CGFloat) {
        self.expressionContext = expressionContext
        self.id = id
        self.parentModel = parentModel
        self.fontSize = fontSize
        
        endCharTextModel = SingularTextModel(id:999, text: .DOLLAR, showCaret: false, isEndChar:true, fontSize: fontSize)
        children.append(endCharTextModel)
        lastFocusedChildrenId = endCharTextModel.id
        self.id = id
    }
    
    func insertChild(_ caretable:Caretable) -> Void {
        let index:Int = childIndexForId(lastFocusedChildrenId) ?? children.count-1
        children.insert(caretable, at:index)
        endCharTextModel.text = .EMPTY
    }
    
    func deleteChild(_ index:Int) {
        self.children.remove(at:index)
        if (self.children.count == 1) {
            endCharTextModel.text = .DOLLAR
        }
    }
    
    func delete() {
        guard var index:Int = childIndexForId(lastFocusedChildrenId) else{
            return
        }
        index-=1
        if (index >= 0) {
            let child = self.children[index]
//            if (child is SquareModel) {
//                //if delete after a square model, then inform square model to handle delete
//                //we will see if needs support other model, currently we only support square model
//                loseFocus()
//                child.handleDeleteFromParent()
//            } else {
                savePreviousState()
                deleteChild(index)
//            }
        } else {
            //suppose I'm the top part of square model
            //I'm already at the beginning position, then inform parent model(square model) to handle
            if (parentModel != nil) {
                parentModel!.handleDeleteFromChild(self)
            }
        }
    }
    func onAC() {
        savePreviousState()
        for i in stride(from:children.count - 2,through:0,by:-1){
            deleteChild(i)
        }
        self.lastFocusedChildrenId = self.children[0].id
        endCharTextModel.text = .DOLLAR
        if(expressionContext != nil){
            endCharTextModel.showCaret = true
        }
    }
    
    func canAddFraction() -> Bool {
        if (expressionContext!.rootExpressionModel!.getData().getMaxFractionLevel() <= 5) {
            return true;
        }
        return false;
    }
    func addFraction() {
        if (!canAddFraction()) {
            //too many levels cause UI slow performance
            return;
        }
        savePreviousState();
        let fractionModel = doAddFraction();
        //hide caret, because the newly added Fraction will show caret
        loseFocus();
        self.lastFocusedChildrenId = fractionModel.id
        
        let merged = initializeMergedExpression(fractionModel);
        if (merged) {
            fractionModel.setFocus(FocusDirectionEnum.RIGHT);
        } else {
            fractionModel.setFocus(FocusDirectionEnum.LEFT);
        }
    }
    
    func doAddFraction() -> FractionModel {
        let fractionModel = FractionModel(expressionContext:self.expressionContext,
                                          id:CustomIdGenerator.generateId(),
                                          showCaret: false, parentModel: self);
        insertChild(fractionModel);
        return fractionModel;
    }
    
    /**
     * when add composite model(fraction/squareRoot),
     * the previous numbers will be moved into them
     * the previous (1+2...) also be moved
     * <p>
     * return false, means no previous numbers
     */
    func initializeMergedExpression(_ caretableModel:Caretable) -> Bool {
        guard var index = children.firstIndex(where: { $0.id == caretableModel.id }) else {
            return false
        }

        index -= 1
        var endPos = index
        var startPos = index

        if isRightParenthesis(endPos) {
            //find the matched leftParenthesis, merge all between the parenthesis
            startPos = findLeftParenthesisIndex(endPos - 1)
        } else if isX(endPos) || isPI(endPos) || isE(endPos) || isMat(endPos) || isVariableABCEDEFxyz(endPos) || isCompositeModel(endPos) {
            //just merge X or PI or E or MatA/MatB/MatC/MatD/MatAns
        } else {
            if !canBeMerged(endPos) {
                return false
            }
            while (startPos - 1 >= 0 && canBeMerged(startPos - 1)) {
                startPos -= 1
            }
        }

        //find out all the previous consecutive numbers;
        var childrenData: [ExpressionItemData] = []
        for i in startPos...endPos {
            childrenData.append(children[i].getData())
        }
        var expressionData = ExpressionData(lastFocusedChildrenId: -1, children: childrenData, id: CustomIdGenerator.generateId())
        //clear them
        for i in (startPos...endPos).reversed() {
            deleteChild(i);
        }
        //apply them to the new caretableModel
        caretableModel.initializeNumberExpression(expressionData)
        return true
    }

    func canBeMerged(_ index:Int) -> Bool {
        //xx.xxxPI
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isNumber() || singularTextModel.isDot();
    }

    func isE(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isE()
    }

    func isPI(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isPI()
    }

    func isX(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isX()
    }

    func isMat(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isMat()
    }

    func isVariableABCEDEFxyz(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isVariableABCEDEFxyz()
    }

    func isCompositeModel(_ index:Int) -> Bool {
        var child = children[index]
        if (child is SingularTextModel) {
            return false
        }
        return true
    }

    func isRightParenthesis(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isRightParenthesis()
    }

    func isLeftParenthesis(_ index:Int) -> Bool {
        var child = children[index]
        if !(child is SingularTextModel) {
            return false
        }
        
        let singularTextModel = child as! SingularTextModel
        return singularTextModel.isLeftParenthesis()
    }

    func findLeftParenthesisIndex(_ index:Int) -> Int {
        if (index <= 0) {
            return 0
        }
        var index = index
        var depth = 1
        while (depth > 0 && index >= 0) {
            if (isLeftParenthesis(index)) {
                depth -= 1
            } else if (isRightParenthesis(index)) {
                depth += 1
            }
            index -= 1
        }
        return index + 1
    }
    
    func addSingularText(_ text:SingularTextEnum) -> Void {
        savePreviousState()
        _ = doAddSingularText(text)
    }
    
    func doAddSingularText(_ text:SingularTextEnum) -> SingularTextModel {
        let newChild = SingularTextModel(id: CustomIdGenerator.generateId(), text: text, showCaret:false,isEndChar:false,fontSize: self.fontSize)
        insertChild(newChild)
        return newChild
    }
    
    func onLeftArrow() {
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret = false
        
        guard var index:Int = childIndexForId(child.id) else {
            return
        }
        
        index-=1
        if (index != -1) {
            lastFocusedChildrenId = children[index].id
            if (children[index] is ArrowListener) {
                //the last focused view is a composite view, when press right, need to move into it
                loseFocus()
                (children[index] as! ArrowListener).setFocus(FocusDirectionEnum.RIGHT)
                return
            }
            children[index].showCaret = true
            return
        }
        
        //if reach to the start
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onLeftArrowFromChild(self)
        } else {
            lastFocusedChildrenId = children[children.count - 1].id
            if (children[children.count - 1] is ArrowListener) {
                //the last focused view is a composite view, when press right, need to move into it
                loseFocus()
                (children[children.count - 1] as! ArrowListener).setFocus(FocusDirectionEnum.RIGHT)
                return
            }
            children[children.count - 1].showCaret = true
        }
    }
    
    func onRightArrow() {
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret = false
        
        if (child is ArrowListener) {
            //the last focused view is a composite view, when press right, need to move into it
            loseFocus()
            (child as! ArrowListener).setFocus(FocusDirectionEnum.LEFT)
            return
        }

        guard var index:Int = childIndexForId(child.id) else {
            return
        }

        index+=1
        if (index != children.count) {
            lastFocusedChildrenId = children[index].id
            children[index].showCaret = true
            return
        }
        //if reach to the end
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onRightArrowFromChild(self)
        } else {
            lastFocusedChildrenId = children[0].id
            children[0].showCaret = true
        }
    }
    
    func onUpArrow() {
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onUpArrowFromChild(self)
        }
    }
    
    func onDownArrow() {
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onDownArrowFromChild(self)
        }
    }
    
    func onShiftLeftArrow() {
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret = false
        children[0].showCaret = true
        lastFocusedChildrenId = children[0].id
    }
    
    func onShiftRightArrow() {
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret = false
        children[children.count - 1].showCaret = true
        lastFocusedChildrenId = children[children.count - 1].id
    }
    
    func onLeftArrowFromChild(_ childModel: any ArrowListener) {
        //move left from childView, now show caret of childView
        lastFocusedChildrenId = (childModel as! Caretable).id
        guard var child = (childModel as? Caretable) else{
            return
        }
        child.showCaret = true
        switchToActive()
    }
    
    func onRightArrowFromChild(_ childModel: any ArrowListener) {
        //move right from childView, now show caret on the next child
        guard let index:Int = childIndexForId((childModel as! Caretable).id) else {
            return
        }
        lastFocusedChildrenId = children[index + 1].id
        children[index + 1].showCaret=true
        switchToActive()
    }
    
    func onUpArrowFromChild(_ childModel: any ArrowListener) {
        //expression view won't handle, this only happens for composite view like fraction
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onUpArrowFromChild(self)
        } else {
            childModel.setFocus(FocusDirectionEnum.ORIGINAL)
        }
    }
    
    func onDownArrowFromChild(_ childModel: any ArrowListener) {
        //expression view won't handle, this only happens for composite view like fraction
        if (parentModel != nil) {
            loseFocus()
            parentModel!.onDownArrowFromChild(self)
        } else {
            childModel.setFocus(FocusDirectionEnum.ORIGINAL)
        }
    }
    
    func setFocus(_ direction: FocusDirectionEnum) {
        if(self.expressionContext == nil){
            //nil means readonly, no need set focus
            return;
        }
        if (direction == FocusDirectionEnum.LEFT) {
            lastFocusedChildrenId = children[0].id
        } else if (direction == FocusDirectionEnum.RIGHT) {
            lastFocusedChildrenId = children[children.count - 1].id
        }
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret=true
        switchToActive()
    }
    
    func loseFocus() {
        guard var child = getLastFocusedChildren() else {
            return
        }
        child.showCaret=false
    }
    
    func handleDeleteFromChild(_ childModel: any ArrowListener) {
        
    }
    
    func getLastFocusedChildren() -> Caretable? {
        for child in children {
            if (child.id == lastFocusedChildrenId) {
                return child
            }
        }
        return nil
    }
    
    func childIndexForId(_ idToFind: Int) -> Int? {
        return children.firstIndex { $0.id == idToFind }
    }
    
    func switchToActive() {
        if(expressionContext != nil){
            expressionContext!.activeExpressionModelId = self.id
        }
    }
    
    func findExpressionModelById(_ expressionModelId:Int ) -> ExpressionModel? {
        if (self.id == expressionModelId) {
            return self;
        }
        for child in self.children {
            let expressionModel = child.findExpressionModelById(expressionModelId);
            if (expressionModel != nil) {
                return expressionModel;
            }
        }
        return nil;
    }
    
    var previousState:ExpressionData?
    func savePreviousState() -> Void {
        self.previousState = getData();
        if(self.expressionContext != nil){
            self.expressionContext!.handleUndoExpressionModelId = self.id;
        }
    }
    func canUndo() -> Bool {
        if (previousState == nil) {
            return false;
        }
        return true;
    }
    
    func getData() -> ExpressionData {
        var childrenData: [ExpressionItemData] = []
        for i in 0..<children.count - 1 {
            childrenData.append(children[i].getData())
        }
        let expressionData = ExpressionData(lastFocusedChildrenId: self.lastFocusedChildrenId, children: childrenData, id: self.id)
        return expressionData;
    }
    
    func undo() -> Void {
        if (previousState == nil) {
            return;
        }
        //important, hide caret, because after replicate, we will find the child to show caret
        loseFocus();
        let currentState = getData();
        //clear all children, except the endChar
        for i in stride(from: children.count - 2, through: 0, by: -1) {
            deleteChild(i)
        }
        //since we have cleared all children, not set lastFocusedChildrenId to endChar, so that
        //during replicate, the newly added widget will be inserted before endChar correctly
        self.lastFocusedChildrenId = self.children[0].id
        //restore to previousState by replicate previous children
        //Note: during replicate, the lastFocusedChildrenId is updated also
        replicate(previousState!);

        let lastFocusedChildren = self.getLastFocusedChildren();
        if let singularTextModel = lastFocusedChildren as? SingularTextModel {
            singularTextModel.showCaret = true
            switchToActive()
        } else if let arrowListener = lastFocusedChildren as? ArrowListener {
            arrowListener.setFocus(.LEFT)
        }

        if (self.children.count == 1) {
            endCharTextModel.text = .DOLLAR
        }
        //then update previousState
        previousState = currentState;
    }
    
    func replicate(_ sourceExpressionData: ExpressionData) {
        doReplicate(sourceExpressionData)
        self.id = sourceExpressionData.id
        for child in children {
            if child.id == sourceExpressionData.lastFocusedChildrenId {
                //if the lastFocusedChildren in sourceData is replicated, means it's not endChar,
                //so update lastFocusedChildrenId as the one in sourceData
                //if not found, means not replicated, means the lastFocusedChildren in sourceData is endChar,
                //in this case, no need to update, because here we already have a new endChar, and it's by default focused
                self.lastFocusedChildrenId = sourceExpressionData.lastFocusedChildrenId
                break
            }
        }
    }
    
    func doReplicate(_ sourceExpressionData: ExpressionData) {
        let sourceChildren = sourceExpressionData.children
        for child in sourceChildren {
            if let singularTextData = child as? SingularTextData {
                let newSingularTextModel = doAddSingularText(.EMPTY)
                newSingularTextModel.replicate(singularTextData)
            } else if let fractionData = child as? FractionData {
                let newFractionModel = doAddFraction()
                newFractionModel.replicate(fractionData)
            }
        }
    }
}
