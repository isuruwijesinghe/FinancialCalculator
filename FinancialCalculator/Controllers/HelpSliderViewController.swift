//
//  HelpSliderViewController.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/3/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class HelpSliderViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let help1 = ["text":"First select what you want to calculate.", "image":"1_new"]
    let help2 = ["text":"Now select the type of the calculation you want.", "image":"2_new"]
    let help3 = ["text":"Now fill the empty fields except the red highlighted one.", "image":"3"]
    let help4 = ["text":"After you fill the empty fields, you will get the answer and the red field will be green.", "image":"4"]
    
    var helpArray = [Dictionary<String,String>]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
                
        helpArray = [help1,help2,help3,help4]

        
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(helpArray.count), height: 520)
        scrollView.showsHorizontalScrollIndicator = false
        
        loadViews()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(" it comes here --> fucker")

        if segue.identifier == "calculateSegue" {
            
            print(" it comes here -->")
            // .. do somtheing
        } else if segue.identifier == "historySegue" {
            // .. do something
            print(" it comes here -->2")

        }
    }
    
    func loadViews(){
        
        for (index,help) in helpArray.enumerated(){
            
            if let helpView = Bundle.main.loadNibNamed("HelpSlider", owner: self, options: nil)?.first as? HelpView {
                
                helpView.helpImage.image = UIImage(named: help["image"]!)
                helpView.helpLabel.text = help["text"]
                
                scrollView.addSubview(helpView)
                helpView.frame.size.width = self.view.bounds.size.width
                helpView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
                
            }
            
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(345))
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}
