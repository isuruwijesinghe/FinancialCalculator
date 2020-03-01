//
//  HelpTableViewCell.swift
//  FinancialCalculator
//
//  Created by Isuru Wijesinghe on 3/1/20.
//  Copyright © 2020 Isuru Wijesinghe. All rights reserved.
//

import UIKit

class HelpTableViewCell: UITableViewCell {

    @IBOutlet weak var formulaNameLablel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
