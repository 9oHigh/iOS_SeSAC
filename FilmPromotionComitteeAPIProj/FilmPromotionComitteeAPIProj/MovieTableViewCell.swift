//
//  MovieTableViewCell.swift
//  FilmPromotionComitteeAPIProj
//
//  Created by 이경후 on 2021/10/26.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    

    static let identifier = "MovieTableViewCell"
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
