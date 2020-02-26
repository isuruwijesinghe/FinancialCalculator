//
//  Selection.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/26/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import Foundation
import UIKit

class Selection {
    let name: String
    let icon: UIImage
    let segueID: String
    let cellColour: UIColor
    
    
    init(name: String, icon: UIImage, segueID: String, cellColour: UIColor) {
        self.name = name
        self.icon = icon
        self.segueID = segueID
        self.cellColour = cellColour
    }
    
    func getConversionName() -> String {
        return name
    }
    
    func getConversionIcon() -> UIImage {
        return icon
    }
    
    func getSegueID() -> String {
        return segueID
    }
    
    func getCellColour() -> UIColor {
        return cellColour
    }
}
