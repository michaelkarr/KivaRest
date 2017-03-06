//
//  KivaTableViewCell.swift
//  KivaRest
//
//  Created by Michael Karr on 3/5/17.
//  Copyright © 2017 Michael Karr. All rights reserved.
//

import UIKit

class KivaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var useLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
