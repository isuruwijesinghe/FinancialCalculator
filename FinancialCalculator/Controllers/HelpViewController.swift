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
        
        // MARK: - Compound Interest Savings
        
        let c_FValue:NSMutableAttributedString = NSMutableAttributedString(string: "A = P(1 + (R / n)(nt)", attributes: [.font:font!])
        c_FValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:17,length:4))
        
        let c_PValue:NSMutableAttributedString = NSMutableAttributedString(string: "P = A / (1 + (R / n)(nt)", attributes: [.font:font!])
        c_PValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:20,length:4))
        
        let c_RValue:NSMutableAttributedString = NSMutableAttributedString(string: "R = n(A / P)(1 / nt) - 1", attributes: [.font:font!])
        c_RValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:12,length:8))
        
        let c_TValue:NSMutableAttributedString = NSMutableAttributedString(string: "t = log(A / P) / n[log(1 + R / n)]", attributes: [.font:font!])
        c_TValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        let c_EPMTValue:NSMutableAttributedString = NSMutableAttributedString(string: "PMT = (AR) / ((1 + R) t - 1)(1 + R * 0)", attributes: [.font:font!])
        c_EPMTValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:21,length:2))
        
        let c_BPMTValue:NSMutableAttributedString = NSMutableAttributedString(string: "PMT = (AR) / ((1 + R) t - 1)(1 + R * 1)", attributes: [.font:font!])
        c_BPMTValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:21,length:2))
        
        formulas.append(Formula.init(type: "Compound Interest Savings", formulaName: ["Future Value", "Principal Value", "Interest Rate", "No . of Times", "End Payment", "Begin Payment"], formulas: [c_FValue, c_PValue, c_RValue, c_TValue, c_EPMTValue, c_BPMTValue]))
        
        // MARK: - Simple Savngs
        
        let s_FValue:NSMutableAttributedString = NSMutableAttributedString(string: "A = P(1 + Rt)", attributes: [.font:font!])
        s_FValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        let s_PValue:NSMutableAttributedString = NSMutableAttributedString(string: "P = A / (1 + Rt)", attributes: [.font:font!])
        s_PValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        let s_RValue:NSMutableAttributedString = NSMutableAttributedString(string: "R = (1/t)(A/P - 1)", attributes: [.font:font!])
        s_RValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        let s_TValue:NSMutableAttributedString = NSMutableAttributedString(string: "t = (R/r)(A/P - 1)", attributes: [.font:font!])
        s_TValue.setAttributes([.font:fontSuper!,.baselineOffset:10], range: NSRange(location:0,length:0))
        
        formulas.append(Formula.init(type: "Simple Savings", formulaName: ["Future Value", "Principal Value", "Interest Rate", "No . of Times"], formulas: [s_FValue, s_PValue, s_RValue, s_TValue]))
        
        // MARK: - Mortgage
        
    }
    
}
