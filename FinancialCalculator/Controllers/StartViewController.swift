//
//  StartViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/9/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    // Create a value for chosed view
    private var nextViewNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "tabBar" {

        let nextView = segue.destination as! UITabBarController

        switch (nextViewNumber) {
        case 1:
            nextView.selectedIndex = 0

        case 2:
            nextView.selectedIndex = 1
            
        case 3:
            nextView.selectedIndex = 2

        default:
            break
            }
        }
    }
    
    @IBAction func CompoundView(_ sender: UIButton) {
        self.nextViewNumber = 1
        self.performSegue(withIdentifier: "tabBar", sender: self)
    }
    
    @IBAction func SavingView(_ sender: UIButton) {
        self.nextViewNumber = 2
        self.performSegue(withIdentifier: "tabBar", sender: self)
    }
    @IBAction func MortgageView(_ sender: UIButton) {
        self.nextViewNumber = 3
        self.performSegue(withIdentifier: "tabBar", sender: self)
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
