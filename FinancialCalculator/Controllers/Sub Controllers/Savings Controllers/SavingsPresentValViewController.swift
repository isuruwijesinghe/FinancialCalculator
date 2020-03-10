//
//  SavingsPresentValViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/29/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class SavingsPresentValViewController: ParentViewController {

    @IBOutlet weak var tf_PresentValue: UITextField!
    @IBOutlet weak var tf_Interest: UITextField!
    @IBOutlet weak var tf_NoOfPayments: UITextField!
    @IBOutlet weak var tf_FutureValue: UITextField!
    var unit: String = "none"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disableKeyBoards()
        getDataWhenReopen()
        
        // Do any additional setup after loading the view.
    }
    
    //save text field data when view disappears
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
            
        }else if (tf_NoOfPayments.isFirstResponder){
            selectedText = tf_NoOfPayments
            unit = "noOfPayments"
            
        }else{
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
                    let alert = UIAlertController(title: "Alert", message: "Do want to clear all the fields ?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
                        self.clearTextFields()
                    }))
                    
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil ))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // method to calculate and update the text fields
    func updateFields(){
        
        if (tf_Interest.text != "0" && tf_FutureValue.text != "0"  && tf_NoOfPayments.text != "0" ) {
            
            //get values update present value
            let futureValue = (tf_FutureValue.text! as NSString).doubleValue
            let noOfPayments = (tf_NoOfPayments.text! as NSString).doubleValue
            var interest = (tf_Interest.text! as NSString).doubleValue
            //convert interest to decimal
            interest = interest / 100
           
            
            let value: Double = Calculations.calSavingsPresentValue(A: futureValue, R: interest, t: noOfPayments)
            
            tf_PresentValue.text = String(format:"%.2f", value)
            
            let redTFColor = UIColor.red
            let greenTFColor = UIColor.green
            
            if tf_PresentValue.text == "0" {
                tf_PresentValue.layer.borderColor = redTFColor.cgColor
                tf_PresentValue.layer.borderWidth = 1.0
            } else{
                tf_PresentValue.layer.borderColor = greenTFColor.cgColor
                tf_PresentValue.layer.borderWidth = 1.0
            }
            
            //            save user entered text field values
            saveTfDataAppClose()
            
        }
        
    }
    
    // save button action
    @IBAction func SaveBtnPressed(_ sender: UIBarButtonItem) {
        var message = "Save Failed ! Please check the text fields."
        
        if(tf_Interest.text != "0" && tf_PresentValue.text != "0"){
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
        return "Principal value = Rs. " + String(format: "%.2f", Double(tf_PresentValue.text!)!) + ", Future value = Rs. " + String(format: "%.2f", Double(tf_FutureValue.text!)!) + ", Interest = " + tf_Interest.text! + "%" + ", No. of payments (years) = " + String(format: "%.2f", Double(tf_NoOfPayments.text!)!)
    }
    
    //save text field data when app is closing
    func saveTfDataAppClose(){
        let defaults = UserDefaults.standard
        defaults.set(tf_PresentValue.text, forKey: "savings_presentValue")
        defaults.set(tf_FutureValue.text, forKey: "savings_futureValue")
        defaults.set(tf_Interest.text, forKey: "savings_interest")
        defaults.set(tf_NoOfPayments.text, forKey: "savings_noOfMonths")
        defaults.synchronize()
    }
    
    // load last added data to text field when app reopen
    func getDataWhenReopen(){
        let defaults = UserDefaults.standard
        tf_PresentValue.text = defaults.string(forKey: "savings_presentValue")
        tf_FutureValue.text = defaults.string(forKey: "savings_futureValue")
        tf_Interest.text = defaults.string(forKey: "savings_interest")
        tf_NoOfPayments.text = defaults.string(forKey: "savings_noOfMonths")
        
        let redTFColor = UIColor.red
        let greenTFColor = UIColor.green
        
        if tf_PresentValue.text == "0" {
            tf_PresentValue.layer.borderColor = redTFColor.cgColor
            tf_PresentValue.layer.borderWidth = 1.0
        } else{
            tf_PresentValue.layer.borderColor = greenTFColor.cgColor
            tf_PresentValue.layer.borderWidth = 1.0
        }
        
    }
    
    // clear all text fields
    func clearTextFields(){
        tf_PresentValue.text = "0"
        tf_FutureValue.text = "0"
        tf_Interest.text = "0"
        tf_NoOfPayments.text = "0"
        
        let redTFColor = UIColor.red
        if tf_PresentValue.text == "0" {
            tf_PresentValue.layer.borderColor = redTFColor.cgColor
            tf_PresentValue.layer.borderWidth = 1.0
        }
    }
    
    // disable soft keyboard
    func disableKeyBoards(){
        tf_PresentValue.inputView = UIView()
        tf_FutureValue.inputView = UIView()
        tf_Interest.inputView = UIView()
        tf_NoOfPayments.inputView = UIView()
    }
    
    //back button action to go to previous view
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
