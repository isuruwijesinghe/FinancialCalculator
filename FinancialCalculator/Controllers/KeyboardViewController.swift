//
//  KeyboardViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/8/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

//    @IBOutlet weak var btnNegate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        btnNegate.isHidden = false

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        let viewController = self.parent as! ParentViewController
        viewController.keyboardKeyPressed(value: (sender.titleLabel?.text!)!)
    }
    
}
