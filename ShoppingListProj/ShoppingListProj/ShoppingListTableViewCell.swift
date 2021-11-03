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
    
    //default
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
