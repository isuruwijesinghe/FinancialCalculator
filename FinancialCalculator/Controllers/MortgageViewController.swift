//
//  MortgageViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/9/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class MortgageViewController: ParentViewController {

    @IBOutlet weak var tf_LoanAmount: UITextField!
    @IBOutlet weak var tf_Interest: UITextField!
    @IBOutlet weak var tf_Payment: UITextField!
    @IBOutlet weak var tf_NoOfMonths: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearTextFields()
        disableKeyBoards()
        getDataWhenReopen()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveTfDataAppClose()
    }
    
     //get inputs from custom keyboard
    override func keyboardKeyPressed(value: String) {
            var selectedText: UITextField? = nil
            var unit: String = "none"
            
            if (tf_LoanAmount.isFirstResponder) {
                selectedText = tf_LoanAmount
                unit = "present"
                
            }else if (tf_Interest.isFirstResponder){
                selectedText = tf_Interest
                unit = "interest"
                
            }else if (tf_Payment.isFirstResponder){
                selectedText = tf_Payment
                unit = "payment"
                
            }else if (tf_NoOfMonths.isFirstResponder){
                selectedText = tf_NoOfMonths
                unit = "noOfPayments"
                
            }else{
                unit = "none"
            }
            
            if(unit != "none"){
                
                if(value != "DEL"){
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
           
           if (tf_LoanAmount.text != "0" && tf_Interest.text != "0"  && tf_NoOfMonths.text != "0") {
            
            //update compounds Per Year
            let presentValue = (tf_LoanAmount.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
//            let payment = (tf_Payment.text! as NSString).doubleValue
            let noOfPayments = (tf_NoOfMonths.text! as NSString).doubleValue
            
            let value : Double = Calculations.calPMTValue(P: presentValue, R: interest, n: noOfPayments)
            
            tf_Payment.text = String(format:"%.2f", value)
        }
        
    }
    
    //save button action
    @IBAction func SaveBtnPressed(_ sender: UIBarButtonItem) {
        
        var message = "Save Failed ! Please check the text fields."
        
        if(tf_LoanAmount.text != "0" && tf_Interest.text != "0"){
            Storage.storeData(key: "mortgage", value: savingItem())
            message = "Succssfully saved !"
        }
        
        let alert = UIAlertController(title: "Data Storage", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // history button action
    @IBAction func HistoryBtnPressed(_ sender: UIBarButtonItem) {
        
        let storage = Storage.getData(key: "mortgage")
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
    
    // creating saving value as a printable string
    func savingItem() -> String{
        return "Loan value = Rs. " + String(format: "%.2f", Double(tf_LoanAmount.text!)!) + ", Interest = " + tf_Interest.text! + "%" + ", No. of months = " + String(format: "%.0f", Double(tf_NoOfMonths.text!)!)  + ", Payment = Rs. " + String(format: "%.2f", Double(tf_Payment.text!)!)
    }
    
    //save text field data when app is closing
    func saveTfDataAppClose(){
        let defaults = UserDefaults.standard
        defaults.set(tf_Interest.text, forKey: "mortgage_interest")
        defaults.set(tf_LoanAmount.text, forKey: "mortgage_loanAmount")
        defaults.set(tf_NoOfMonths.text, forKey: "mortgage_noOfMonths")
        defaults.set(tf_Payment.text, forKey: "mortgage_payment")
        defaults.synchronize()
    }
    
    // load last added data to text field when app reopen
    func getDataWhenReopen(){
        let defaults = UserDefaults.standard
        tf_Interest.text = defaults.string(forKey: "mortgage_interest")
        tf_LoanAmount.text = defaults.string(forKey: "mortgage_loanAmount")
        tf_NoOfMonths.text = defaults.string(forKey: "mortgage_noOfMonths")
        tf_Payment.text = defaults.string(forKey: "mortgage_payment")

    }
    
    // clear all text fields
    func clearTextFields(){
        tf_LoanAmount.text = "0"
        tf_Interest.text = "0"
        tf_Payment.text = "0"
        tf_NoOfMonths.text = "0"
    }
    
    // disable soft keyboard
    func disableKeyBoards(){
        tf_LoanAmount.inputView = UIView()
        tf_Interest.inputView = UIView()
        tf_Payment.inputView = UIView()
        tf_NoOfMonths.inputView = UIView()
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
