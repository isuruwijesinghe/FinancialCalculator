//
//  MortgageSelectionViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/27/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class MortgageSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selections = ["Payment", "Present Value", "Interest", "No. of Years"]
    var selected : String? = "Payment"
    @IBOutlet weak var mortgagePickerView: UIPickerView!
    @IBOutlet weak var buttonConfirmCalculation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting picker views default value to the 0th position
        mortgagePickerView.selectRow(0, inComponent: 0, animated: true)
        
//        buttonConfirmCalculation border in black with 5 corner radius
        buttonConfirmCalculation.backgroundColor = .clear
        buttonConfirmCalculation.layer.cornerRadius = 5
        buttonConfirmCalculation.layer.borderWidth = 1.0
        buttonConfirmCalculation.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00).cgColor

        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selections.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = selections[row]
    }
    
    
    @IBAction func calculationButtonPressed(_ sender: UIButton) {
        
        switch selected {
        case "Payment":
            self.performSegue(withIdentifier: "mortgagePaymentSegue", sender: self)
        case "Present Value":
            self.performSegue(withIdentifier: "mortgagePresentValSegue", sender: self)
        case "Interest":
            self.performSegue(withIdentifier: "mortgageInterestValSegue", sender: self)
        case "No. of Years":
            self.performSegue(withIdentifier: "mortgageNoYearsValSegue", sender: self)
        default:
            self.performSegue(withIdentifier: "mortgagePaymentSegue", sender: self)
        }
        
    }
    
}
