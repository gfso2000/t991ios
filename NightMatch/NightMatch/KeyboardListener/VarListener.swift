//
//  VarListener.swift
//  NightMatch
//
//  Created by Yu, Jack on 2024/10/16.
//

import Foundation

protocol VarListener {
    func showVar()->Bool
    func addVar(_ varName:String)->Void
}
