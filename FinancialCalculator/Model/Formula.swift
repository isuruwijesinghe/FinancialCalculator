//
//  Formula.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/1/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation

class Formula{
    
    let type: String
    let formulaName :[String]
    let formulas : [NSAttributedString]
    
    init(type: String, formulaName : [String], formulas: [NSAttributedString]) {
        self.type = type
        self.formulaName = formulaName
        self.formulas = formulas
    }
}
