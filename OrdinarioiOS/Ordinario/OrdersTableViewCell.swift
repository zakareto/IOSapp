//
//  OrdersTableViewCell.swift
//  Ordinario
//
//  Created by Rafael Raygosa Mena on 08/06/22.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var StatusLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var productsLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
