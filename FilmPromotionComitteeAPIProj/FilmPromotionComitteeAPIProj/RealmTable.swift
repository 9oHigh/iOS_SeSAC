//
//  RealmTable.swift
//  FilmPromotionComitteeAPIProj
//
//  Created by 이경후 on 2021/11/02.
//

import Foundation
import RealmSwift

class DailyMovie : Object{
    
    @Persisted var name : String
    
    @Persisted var date : String
    
    @Persisted var inputDate : String
    
    @Persisted(primaryKey: true) var movieId : ObjectId
    
    convenience init(name : String, date: String, inputDate : String){
        self.init()
        self.name = name
        self.date = date
        self.inputDate = inputDate
    }
}
