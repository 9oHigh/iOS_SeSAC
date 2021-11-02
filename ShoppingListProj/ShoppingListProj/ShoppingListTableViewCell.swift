//
//  ShoppingListTableViewCell.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/10/13.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    //버튼, 라벨
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var shopListLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    //Images
    
    let unCheckedImage = UIImage(systemName: "checkmark.square")
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let unStarredImage = UIImage(systemName: "star")
    let StarredImage = UIImage(systemName: "star.fill")
    
    //default
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.setImage(unCheckedImage, for: .normal)
        starButton.setImage(unStarredImage, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    //셀간 간격을 줄 수 있는 함수
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
        contentView.layer.cornerRadius = 15
        
    }
}
