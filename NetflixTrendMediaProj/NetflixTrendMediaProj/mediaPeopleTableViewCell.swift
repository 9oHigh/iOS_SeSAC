//
//  mediaPeopleTableViewCell.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/18.
//

import UIKit

class mediaPeopleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorDescriptLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
