//
//  RealmTable.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/11/02.
//

import Foundation
import RealmSwift
import UIKit

class ShopList : Object{
    //체크박스 Bool
    @Persisted var checkClicked : Bool
    //스타박스 Bool
    @Persisted var starClicked : Bool
    //이름
    @Persisted var name : String
    //주키
    @Persisted(primaryKey: true) var _id : ObjectId
    
    convenience init(name : String) {
        self.init()
        self.name = name
        self.checkClicked = false
        self.starClicked = false
    }
}
