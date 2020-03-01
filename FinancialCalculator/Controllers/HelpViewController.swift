//
//  HelpViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/1/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var formulas = [Formula]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFormulasWithSupperScripts()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return formulas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formulas[section].formulas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return formulas[section].type
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HelpTableViewCell
        cell.formulaNameLablel.text = formulas[indexPath.section].formulaName[indexPath.row]
        cell.formulaLabel.attributedText = formulas[indexPath.section].formulas[indexPath.row]
//        cell.textLabel?.text = formulas[indexPath.section].formulas[indexPath.row]
        return cell
        
    }
    
    func setFormulasWithSupperScripts(){
        
        let font:UIFont? = UIFont(name: "Helvetica", size:16)
        let fontSuper:UIFont? = UIFont(name: "Helvetica", size:10)
        
        let c_FValue:NSMutableAttributedString = NSMutableAttributedString(string: "A = P(1 + (R / n)(nt)", attributes: [.font:font!])
        c_FValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:17,length:4))
        
        let c_PValue:NSMutableAttributedString = NSMutableAttributedString(string: "P = A / (1 + (R / n)(nt)", attributes: [.font:font!])
        c_PValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:4))
        
        let c_RValue:NSMutableAttributedString = NSMutableAttributedString(string: "R = n(A / P)(1 / nt) - 1", attributes: [.font:font!])
        c_RValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:12,length:8))
        
        let c_TValue:NSMutableAttributedString = NSMutableAttributedString(string: "t = log(A / P) / n[log(1 + R / n)]", attributes: [.font:font!])
        c_TValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        formulas.append(Formula.init(type: "Compound Interest Savings", formulaName: ["Future Value", "Principal Value", "Interest Rate", "No . of Times"], formulas: [c_FValue, c_PValue, c_RValue, c_TValue]))
        
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
