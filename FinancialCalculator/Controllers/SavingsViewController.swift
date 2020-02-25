//
//  SavingsViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/23/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class SavingsViewController: ParentViewController {
    
    @IBOutlet weak var tf_PresentValue: UITextField!
    @IBOutlet weak var tf_FutureValue: UITextField!
    @IBOutlet weak var tf_Interest: UITextField!
    @IBOutlet weak var tf_Payment: UITextField!
    @IBOutlet weak var tf_NoOfPayments: UITextField!
    @IBOutlet weak var tf_TotalValue: UITextField!
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
            
        }else if (tf_TotalValue.isFirstResponder){
            selectedText = tf_TotalValue
            unit = "totalValue"
            
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
        
        if (tf_FutureValue.text != "0" && tf_PresentValue.text != "0" && tf_Interest.text != "0" && tf_Payment.text != "0"  && tf_NoOfPayments.text != "0" && tf_TotalValue.text != "0" ){
            
            //get values update total value
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            let PMT = (tf_Payment.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            let compoundsPerYear = 12.00 //compounds per year is 12 by default cuz year has 12 months
            
            switch unit {
            case "present":
                //change in present value field
                let totalValue = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
                
                tf_TotalValue.text = String(format:"%.2f", totalValue)
            case "future":
                //change in future value field
                let totalValue = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
                
                tf_TotalValue.text = String(format:"%.2f", totalValue)
                
            case "interest":
                //change in interest field
                let futureValue: Double = Calculations.calSavingsFutureValue(PMT: PMT, R: interest, t: noOfPayments, n: compoundsPerYear)
                
                tf_FutureValue.text = String(format:"%.2f", futureValue)
                
                if tf_PresentValue.text != "0" {
                    
                    let totalValue: Double = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
                    
                    tf_TotalValue.text = String(format:"%.2f", totalValue)
                }
            case "noOfPayments":
                //change in no of payments field
                let futureValue: Double = Calculations.calSavingsFutureValue(PMT: PMT, R: interest, t: noOfPayments, n: compoundsPerYear)
                
                tf_FutureValue.text = String(format:"%.2f", futureValue)
                
                if tf_PresentValue.text != "0" {
                    
                    let totalValue: Double = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
                    
                    tf_TotalValue.text = String(format:"%.2f", totalValue)
                }
            case "payment":
                //change in monthly payments field
                let futureValue: Double = Calculations.calSavingsFutureValue(PMT: PMT, R: interest, t: noOfPayments, n: compoundsPerYear)
                
                tf_FutureValue.text = String(format:"%.2f", futureValue)
                if tf_PresentValue.text != "0" {
                    
                    let totalValue: Double = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
                    
                    tf_TotalValue.text = String(format:"%.2f", totalValue)
                }
            default:
                print("unit value is none")
            }
            

            
        }else if (tf_Interest.text != "0" && tf_Payment.text != "0"  && tf_NoOfPayments.text != "0" ) {
            
            //get values update future value
            let PMT = (tf_Payment.text! as NSString).doubleValue
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
            let compoundsPerYear = 12.00 //compounds per year is 12 by default cuz year has 12 months
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            
            let value: Double = Calculations.calSavingsFutureValue(PMT: PMT, R: interest, t: noOfPayments, n: compoundsPerYear)
            
            tf_FutureValue.text = String(format:"%.2f", value)
            
            if tf_PresentValue.text != "0" {
                
                let totalValue: Double = Calculations.calSavingsTotalValue(P: presentValue, A: value)
                
                tf_TotalValue.text = String(format:"%.2f", totalValue)
            }
            
        }else if (tf_FutureValue.text != "0" && tf_PresentValue.text != "0"){
            
            //get values update total value
            let presentValue = (tf_PresentValue.text! as NSString).doubleValue
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            
            let value: Double = Calculations.calSavingsTotalValue(P: presentValue, A: futureValue)
            
            tf_TotalValue.text = String(format:"%.2f", value)
            
        }
                
    }
    
    // save button action
    @IBAction func SaveBtnPressed(_ sender: UIBarButtonItem) {
        var message = "Save Failed ! Please check the text fields."
        
        if(tf_Interest.text != "0" && tf_FutureValue.text != "0"){
            Storage.storeData(key: "savings", value: savingItem())
            message = "Succssfully saved !"
        }
        
        let alert = UIAlertController(title: "Data Storage", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // history button action
    @IBAction func HistoryBtnPressed(_ sender: UIBarButtonItem) {
        
        let storage = Storage.getData(key: "savings")
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
        return "Principal value = Rs. " + String(format: "%.2f", Double(tf_PresentValue.text!)!) + ", Future value = Rs. " + String(format: "%.2f", Double(tf_FutureValue.text!)!) + ", Interest = " + tf_Interest.text! + "%" + ", No. of payments (years) = " + String(format: "%.2f", Double(tf_NoOfPayments.text!)!)  + ", Payment = Rs. " + String(format: "%.2f", Double(tf_Payment.text!)!) + ", Total Value = Rs. " + String(format: "%.2f", Double(tf_TotalValue.text!)!)
    }
    
    //save text field data when app is closing
    func saveTfDataAppClose(){
        let defaults = UserDefaults.standard
        defaults.set(tf_PresentValue.text, forKey: "savings_presentValue")
        defaults.set(tf_FutureValue.text, forKey: "savings_futureValue")
        defaults.set(tf_Interest.text, forKey: "savings_interest")
        defaults.set(tf_Payment.text, forKey: "savings_payment")
        defaults.set(tf_NoOfPayments.text, forKey: "savings_noOfMonths")
        defaults.set(tf_TotalValue.text, forKey: "savings_totalValue")
        defaults.synchronize()
    }
    
    // load last added data to text field when app reopen
    func getDataWhenReopen(){
        let defaults = UserDefaults.standard
        tf_PresentValue.text = defaults.string(forKey: "savings_presentValue")
        tf_FutureValue.text = defaults.string(forKey: "savings_futureValue")
        tf_Interest.text = defaults.string(forKey: "savings_interest")
        tf_Payment.text = defaults.string(forKey: "savings_payment")
        tf_NoOfPayments.text = defaults.string(forKey: "savings_noOfMonths")
        tf_TotalValue.text = defaults.string(forKey: "savings_totalValue")

    }
    
    // clear all text fields
       func clearTextFields(){
           tf_PresentValue.text = "0"
           tf_FutureValue.text = "0"
           tf_Interest.text = "0"
           tf_Payment.text = "0"
           tf_NoOfPayments.text = "0"
           tf_TotalValue.text = "0"
       }
       
       // disable soft keyboard
       func disableKeyBoards(){
           tf_PresentValue.inputView = UIView()
           tf_FutureValue.inputView = UIView()
           tf_Interest.inputView = UIView()
           tf_Payment.inputView = UIView()
           tf_NoOfPayments.inputView = UIView()
           tf_TotalValue.inputView = UIView()
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
