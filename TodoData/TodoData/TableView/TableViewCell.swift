//
//  TableViewCell.swift
//  TodoData
//
//  Created by Droadmin on 11/12/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var dbDateLbl: UILabel!
    @IBOutlet weak var dbNameLbl: UILabel!
    @IBOutlet weak var dbImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
