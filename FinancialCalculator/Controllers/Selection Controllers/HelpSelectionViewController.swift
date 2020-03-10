//
//  HelpSelectionViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/5/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class HelpSelectionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //    send bool values to each segues to set different arrays
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculateSegue" {
            
            let mainVC = segue.destination as! HelpSliderViewController
            mainVC.isCalculate = true
            
        } else if segue.identifier == "historySegue" {
            
            let mainVC = segue.destination as! HelpSliderViewController
            mainVC.isCalculate = false
        }
    }
    
    //    back button action to go to previous view
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
