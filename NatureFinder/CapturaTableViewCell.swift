//
//  CapturaTableViewCell.swift
//  NatureFinder
//
//  Created by Donato Alfonso Tovar De la Herran on 4/1/17.
//  Copyright © 2017 Donato Alfonso Tovar De la Herran. All rights reserved.
//

import UIKit

class CapturaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenAnimal: UIImageView!
    @IBOutlet weak var lbAnimal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
