//
//  KeyboardViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/8/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class KeyboardViewController: UIViewController {

    @IBOutlet weak var btnNegate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNegate.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func keyboardButtonPressed(_ sender: UIButton) {
        let viewController = self.parent as! ParentViewController
        viewController.keyboardKeyPressed(value: (sender.titleLabel?.text!)!)
    }
    
}
