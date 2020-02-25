//
//  CompoundViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/8/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class CompoundViewController: ParentViewController {

    @IBOutlet weak var tf_PresentValue: UITextField!
    @IBOutlet weak var tf_FutureValue: UITextField!
    @IBOutlet weak var tf_Interest: UITextField!
    @IBOutlet weak var tf_Payment: UITextField!
    @IBOutlet weak var tf_NoOfPayments: UITextField!
    @IBOutlet weak var tf_CompoundsPerYear: UITextField!
    @IBOutlet weak var BeginEndSwitch: UISwitch!
    @IBOutlet weak var beginEndLabel: UILabel!
    var switchValue : String = "End"
    var unit: String = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearTextFields()
        disableKeyBoards()
        getDataWhenReopen()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        saveTfDataAppClose()
    }
    
    // Begin End Switch value check
    @IBAction func switchValueCheck(_ sender: UISwitch) {

        if BeginEndSwitch.isOn{
            switchValue = "End"
            unit = "payment"
            beginEndLabel.text = switchValue
            updateFields()
        }else {
            switchValue = "Begin"
            unit = "payment"
            beginEndLabel.text = switchValue
            updateFields()
        }
        
    }
    
    //get inputs from custom keyboard
    override func keyboardKeyPressed(value: String) {
        var selectedText: UITextField? = nil
        
        
        if (tf_PresentValue.isFirstResponder) {
            selectedText = tf_PresentValue
            unit = "present"
            
        }else if (tf_FutureValue.isFirstResponder){
            selectedText = tf_FutureValue
            unit = "future"
            
        }else if (tf_Interest.isFirstResponder){
            selectedText = tf_Interest
            unit = "interest"
            
        }else if (tf_Payment.isFirstResponder){
            selectedText = tf_Payment
            unit = "payment"
            
        }else if (tf_NoOfPayments.isFirstResponder){
            selectedText = tf_NoOfPayments
            unit = "noOfPayments"
            
        }else if (tf_CompoundsPerYear.isFirstResponder){
            selectedText = tf_CompoundsPerYear
            unit = "compoundsPerYear"
            
        }
        else{
            unit = "none"
        }
        
        if(unit != "none"){
            
            
            if(value == "NEG"){
                // Check if NEG("-") is already there
                if(!(value == "NEG" && (selectedText?.text?.contains("-"))!)){
                    let currentText = selectedText?.text
                    selectedText?.text?.insert("-", at: (currentText?.index(currentText!.startIndex, offsetBy: 0))!)
                }
                
            }else if(value != "DEL"){
                // Check if decimal place is already there
                 if(!(value == "." && (selectedText?.text?.contains("."))!))
                     {
                        selectedText?.text = ((selectedText?.text!)!) + value
                                   
                            if(selectedText?.text?.first == "0") {
                                    selectedText?.text=String((selectedText?.text?.dropFirst())!)
                                   }
                                updateFields()
                        }
            }else{
                selectedText?.text = String((selectedText?.text?.dropLast())!)
                
                if((selectedText?.text?.count)! > 0) {
                    updateFields()
                } else {
                    clearTextFields()
                }
            }
        }
    }
    
    // method to calculate and update the text fields
    func updateFields(){
        
        if (tf_PresentValue.text != "0" && tf_FutureValue.text != "0" && tf_Interest.text != "0"  && tf_NoOfPayments.text != "0" && tf_CompoundsPerYear.text != "0" && tf_Payment.text != "0") {

            //get values to update the fields
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            let compoundsPerYear = (tf_CompoundsPerYear.text! as NSString).doubleValue
        
            switch unit {
            case "present":
                //change in present value field
                let futureValue = Calculations.calFutureValue(P: presentValue, R: interest, n: compoundsPerYear, t:noOfPayments )
                
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }
            
                tf_FutureValue.text = String(format:"%.2f", futureValue)
            case "future":
                //change in future value field
                let presentValue = Calculations.calPrincipalValue(A: futureValue, R: interest, n: compoundsPerYear, t:noOfPayments )
                
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }
                tf_PresentValue.text = String(format:"%.2f", presentValue)
            case "interest":
                //change in interest field
                let futureValue = Calculations.calFutureValue(P: presentValue, R: interest, n: compoundsPerYear, t:noOfPayments )
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }
                tf_FutureValue.text = String(format:"%.2f", futureValue)
            case "compoundsPerYear":
                //change in compounds per year field
                let futureValue = Calculations.calFutureValue(P: presentValue, R: interest, n: compoundsPerYear, t:noOfPayments )
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }
                tf_FutureValue.text = String(format:"%.2f", futureValue)
            case "noOfPayments":
                //change in no of payments field
                let futureValue = Calculations.calFutureValue(P: presentValue, R: interest, n: compoundsPerYear, t:noOfPayments )
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                    tf_Payment.text = String(format:"%.2f", value)
                }
                tf_FutureValue.text = String(format:"%.2f", futureValue)
            case "payment":
                //update PMT after compounds per year calculation
                if beginEndLabel.text == "End"{
                    let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: compoundsPerYear)
                    tf_Payment.text = String(format:"%.2f", value)
                }else if beginEndLabel.text == "Begin"{
                    let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: compoundsPerYear)
                    tf_Payment.text = String(format:"%.2f", value)
                }
            default:
                print("unit value is none")
            }

        }else if (tf_PresentValue.text != "0" && tf_FutureValue.text != "0" && tf_Interest.text != "0"  && tf_CompoundsPerYear.text != "0" ) {
            
            //get values update times per year
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
            let compoundsPerYear = (tf_NoOfPayments.text! as NSString).doubleValue
            
            let value: Double = Calculations.calTimesValue(A: futureValue, P: presentValue, R: interest, n: compoundsPerYear)
            
            
            tf_NoOfPayments.text = String(format:"%.0f", value)
            
            //update PMT after compounds per year calculation
            if beginEndLabel.text == "End"{
                let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: value)
                tf_Payment.text = String(format:"%.2f", value)
            }else if beginEndLabel.text == "Begin"{
                let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: value)
                tf_Payment.text = String(format:"%.2f", value)
            }
            
        }else if(tf_FutureValue.text != "0" && tf_Interest.text != "0" && tf_NoOfPayments.text != "0" && tf_CompoundsPerYear.text != "0"){
            
            //update the present value
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
             //convert interest to decimal
            interest = interest / 100
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            let compoundsPerYear = (tf_CompoundsPerYear.text! as NSString).doubleValue
            
            let value: Double = Calculations.calPrincipalValue(A: futureValue, R: interest, n: compoundsPerYear, t: noOfPayments)
            
            tf_PresentValue.text = String(format:"%.2f", value)
            
            //update PMT after present value calculation
            if beginEndLabel.text == "End"{
                let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }else if beginEndLabel.text == "Begin"{
                let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }
            
        }else if(tf_PresentValue.text != "0" && tf_FutureValue.text == "0" && tf_Interest.text != "0" && tf_NoOfPayments.text != "0" && tf_CompoundsPerYear.text != "0"){
            
            //update update the future value
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
             //convert interest to decimal
            interest = interest / 100
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            let compoundsPerYear = (tf_CompoundsPerYear.text! as NSString).doubleValue
            
            let value: Double = Calculations.calFutureValue(P: presentValue, R: interest, n: compoundsPerYear, t: noOfPayments)
            
            tf_FutureValue.text = String(format:"%.2f", value)
            
            //update PMT after future value calculation
            if beginEndLabel.text == "End"{
                let value: Double = Calculations.calEndPMTValue(A: value, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }else if beginEndLabel.text == "Begin"{
                let value: Double = Calculations.calBeginPMTValue(A: value, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }
            
        }else if(tf_PresentValue.text != "0" && tf_FutureValue.text != "0" && tf_NoOfPayments.text != "0" && tf_CompoundsPerYear.text != "0"){
            
            //update interest
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            let compoundsPerYear = (tf_CompoundsPerYear.text! as NSString).doubleValue
            
            var value :Double = Calculations.calInterestRate(A: futureValue, P: presentValue, n: compoundsPerYear, t: noOfPayments)
            
            value = value * 100
            
            tf_Interest.text = String(format:"%.0f", value)
            
            //update PMT after interest calculation
            if beginEndLabel.text == "End"{
                let value: Double = Calculations.calEndPMTValue(A: futureValue, R: value/100, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }else if beginEndLabel.text == "Begin"{
                let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: value/100, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }
        
        }else if(tf_FutureValue.text != "0" && tf_Interest.text != "0" && tf_NoOfPayments.text != "0"){
            
            //update PMT (payment) with End and Begin check
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
             //convert interest to decimal
            interest = interest / 100
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            
            if beginEndLabel.text == "End"{
                let value: Double = Calculations.calEndPMTValue(A: futureValue, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }else if beginEndLabel.text == "Begin"{
                let value: Double = Calculations.calBeginPMTValue(A: futureValue, R: interest, t: noOfPayments)
                tf_Payment.text = String(format:"%.2f", value)
            }
        }
    }
    
    // save button action
    @IBAction func SaveBtnPressed(_ sender: UIBarButtonItem) {
        var message = "Save Failed ! Please check the text fields."
        
        if(tf_PresentValue.text != "0" && tf_FutureValue.text != "0"){
            Storage.storeData(key: "compound", value: savingItem())
            message = "Succssfully saved !"
        }
        
        let alert = UIAlertController(title: "Data Storage", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // history button action
    @IBAction func HistoryBtnPressed(_ sender: UIBarButtonItem) {
        
        let storage = Storage.getData(key: "compound")
        if(storage.count > 0){
         // History page list code here
            let destination = storyboard?.instantiateViewController(withIdentifier: "historyView") as! HistoryViewController
            destination.storage = storage
            self.present(destination, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Error Alert", message: "No history found !", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // creating saving value as a string
    func savingItem() -> String{
        return "Principal value = Rs. " + String(format: "%.2f", Double(tf_PresentValue.text!)!) + ", Future value = Rs. " + String(format: "%.2f", Double(tf_FutureValue.text!)!) + ", Interest = " + tf_Interest.text! + "%" + ", No. of payments = " + String(format: "%.0f", Double(tf_NoOfPayments.text!)!)  + ", Compounds per year = " + String(format: "%.0f", Double(tf_CompoundsPerYear.text!)!) + ", Payment = Rs. " + String(format: "%.2f", Double(tf_Payment.text!)!)
    }
    
    //save text field data when app is closing
    func saveTfDataAppClose(){
        let defaults = UserDefaults.standard
        defaults.set(tf_PresentValue.text, forKey: "compound_presentValue")
        defaults.set(tf_FutureValue.text, forKey: "compound_futureValue")
        defaults.set(tf_Interest.text, forKey: "compound_interest")
        defaults.set(tf_Payment.text, forKey: "compound_payment")
        defaults.set(tf_NoOfPayments.text, forKey: "compound_noOfMonths")
        defaults.set(tf_CompoundsPerYear.text, forKey: "compound_compoundsPerYear")
        defaults.synchronize()
    }
    
    // load last added data to text field when app reopen
    func getDataWhenReopen(){
        let defaults = UserDefaults.standard
        tf_PresentValue.text = defaults.string(forKey: "compound_presentValue")
        tf_FutureValue.text = defaults.string(forKey: "compound_futureValue")
        tf_Interest.text = defaults.string(forKey: "compound_interest")
        tf_Payment.text = defaults.string(forKey: "compound_payment")
        tf_NoOfPayments.text = defaults.string(forKey: "compound_noOfMonths")
        tf_CompoundsPerYear.text = defaults.string(forKey: "compound_compoundsPerYear")

    }
    
    
    // clear all text fields
    func clearTextFields(){
        tf_PresentValue.text = "0"
        tf_FutureValue.text = "0"
        tf_Interest.text = "0"
        tf_Payment.text = "0"
        tf_NoOfPayments.text = "0"
        tf_CompoundsPerYear.text = "0"
    }
    
    // disable soft keyboard
    func disableKeyBoards(){
        tf_PresentValue.inputView = UIView()
        tf_FutureValue.inputView = UIView()
        tf_Interest.inputView = UIView()
        tf_Payment.inputView = UIView()
        tf_NoOfPayments.inputView = UIView()
        tf_CompoundsPerYear.inputView = UIView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
