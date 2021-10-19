//
//  bookCollectionViewCell.swift
//  NetflixTrendMediaProj
//
//  Created by 이경후 on 2021/10/19.
//

import UIKit

class bookCollectionViewCell: UICollectionViewCell {

    static let identifier = "bookCollectionViewCell"
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
