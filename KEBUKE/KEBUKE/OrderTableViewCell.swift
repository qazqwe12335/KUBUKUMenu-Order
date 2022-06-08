//
//  OrderTableViewCell.swift
//  KEBUKE
//
//  Created by 張軒瑋 on 2022/5/22.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderTeam: UILabel!
    @IBOutlet weak var orderDrinkName: UILabel!
    @IBOutlet weak var orderDrinkSize: UILabel!
    @IBOutlet weak var orderDrinkPrice: UILabel!
    @IBOutlet weak var orderDrinkSugar: UILabel!
    @IBOutlet weak var orderDrinkIce: UILabel!
    @IBOutlet weak var Remark: UILabel!
    @IBOutlet weak var orderDateTime: UILabel!
    @IBOutlet weak var bubble: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
