//
//  summaryTableViewCell.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/19.
//

import UIKit

class summaryTableViewCell: UITableViewCell {

    static let identifier = "summaryTableViewCell"
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
