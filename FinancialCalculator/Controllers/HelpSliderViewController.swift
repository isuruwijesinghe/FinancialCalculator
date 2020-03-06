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
    let help5 = ["text":"Click on the save buton to save the calculations.", "image":"5"]
    let help6 = ["text":"Click on History button to view the saved calculations.", "image":"6"]
    let help7 = ["text":"You will get history view like this.", "image":"7"]
    
    var helpArray = [Dictionary<String,String>]()
    
    var vcOne : Bool = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(vcOne)
        {
            helpArray = [help1,help2,help3,help4]
            scrollView.isPagingEnabled = true
            scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(helpArray.count), height: 520)
            scrollView.showsHorizontalScrollIndicator = false
            
            pageControl.numberOfPages = helpArray.count
            loadViews()
            
        }
        else
        {
            helpArray = [help5,help6,help7]
            scrollView.isPagingEnabled = true
            scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(helpArray.count), height: 520)
            scrollView.showsHorizontalScrollIndicator = false
            
            pageControl.numberOfPages = helpArray.count
            loadViews()
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
