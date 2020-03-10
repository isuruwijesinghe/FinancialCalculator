//
//  LoanSelectionViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/9/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class LoanSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selections = ["Payment", "Present Value", "Interest", "No. of Years"]
    var selected : String? = "Payment"
    @IBOutlet weak var loanPickerView: UIPickerView!
    @IBOutlet weak var buttonConfirmCalculation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting picker views default value to the 0th position
        loanPickerView.selectRow(0, inComponent: 0, animated: true)
        
        //        buttonConfirmCalculation border in black with 5 corner radius
        buttonConfirmCalculation.backgroundColor = .clear
        buttonConfirmCalculation.layer.cornerRadius = 5
        buttonConfirmCalculation.layer.borderWidth = 1.0
        buttonConfirmCalculation.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00).cgColor
        
        
        // Do any additional setup after loading the view.
    }
    
    //    pickerview set number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //    pickerview set number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selections.count
    }
    
    //    pickerview set titles for rows
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selections[row]
    }
    
    //    pickerciew get selected row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = selections[row]
    }
    
    //    calculation button action to go to selected segue
    @IBAction func calculationButtonPressed(_ sender: UIButton) {
        
        switch selected {
        case "Payment":
            self.performSegue(withIdentifier: "loanPaymentSegue", sender: self)
        case "Present Value":
            self.performSegue(withIdentifier: "loanPresentValSegue", sender: self)
        case "Interest":
            self.performSegue(withIdentifier: "loanInterestValSegue", sender: self)
        case "No. of Years":
            self.performSegue(withIdentifier: "loanNoYearsValSegue", sender: self)
        default:
            self.performSegue(withIdentifier: "loanPaymentSegue", sender: self)
        }
        
    }
    
}
