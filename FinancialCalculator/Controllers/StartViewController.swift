//
//  StartViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 2/9/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    // Create a value for chosed view
    private var nextViewNumber = Int()
    
    var selections = [Selection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genSelections()
      
        // Do any additional setup after loading the view.
    }
    
    func genSelections(){
        
        let compoundInterest = Selection(name: "Compound Interest", icon: UIImage(named: "pigBank")!, segueID: "1", cellColour: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00))
        
        let savings = Selection(name: "Savings", icon: UIImage(named: "savings")!, segueID: "2", cellColour: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00))
        
        let loan = Selection(name: "Loan", icon: UIImage(named: "loan")!, segueID: "3", cellColour: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00))
        
         let mortgage = Selection(name: "Mortgage", icon: UIImage(named: "mortage")!, segueID: "4", cellColour: UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.00))
        
        selections += [compoundInterest, savings, loan, mortgage]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectionsCollectionViewCell
        
        cell.selectionImage.image = selections[indexPath.row].getConversionIcon()
        cell.selectionLabel.text = selections[indexPath.row].getConversionName()
        
        //Card(cell) styles
        cell.contentView.backgroundColor = selections[indexPath.row].getCellColour()
        cell.contentView.layer.cornerRadius = 6.0
        cell.contentView.layer.masksToBounds = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nextViewNumber = Int(selections[indexPath.row].getSegueID())!
        self.performSegue(withIdentifier: "tabBar", sender: self)
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
            
        case 4:
            nextView.selectedIndex = 3

        default:
            break
            }
        }
    }
//
//    @IBAction func CompoundView(_ sender: UIButton) {
//        self.nextViewNumber = 1
//        self.performSegue(withIdentifier: "tabBar", sender: self)
//    }
//
//    @IBAction func SavingView(_ sender: UIButton) {
//        self.nextViewNumber = 2
//        self.performSegue(withIdentifier: "tabBar", sender: self)
//    }
//    @IBAction func MortgageView(_ sender: UIButton) {
//        self.nextViewNumber = 3
//        self.performSegue(withIdentifier: "tabBar", sender: self)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
