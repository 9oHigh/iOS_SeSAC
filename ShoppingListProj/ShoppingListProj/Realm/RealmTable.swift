//
//  RealmTable.swift
//  ShoppingListProj
//
//  Created by 이경후 on 2021/11/02.
//

import RealmSwift

class ShopList : Object{
    //체크박스 Bool
    @Persisted var checkClicked : Bool
    //즐겨찾기 박스 Bool
    @Persisted var starClicked : Bool
    //이름
    @Persisted var name : String
    //uuid
    @Persisted(primaryKey: true) var _id : ObjectId
    //초기화
    convenience init(name : String) {
        self.init()
        self.name = name
        self.checkClicked = false
        self.starClicked = false
    }
}
