//
//  MenuTableViewCell.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/17.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var largeCupPriceLabel: UILabel!
    @IBOutlet weak var mediumCupLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
