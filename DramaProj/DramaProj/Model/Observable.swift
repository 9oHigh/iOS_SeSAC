//
//  Observable.swift
//  DramaProj
//
//  Created by 이경후 on 2021/12/30.
//

import Foundation

class Observable<T> {
    
    private var listener : ( (T) -> Void )?
    
    var value : T {
        didSet{
            listener?(value)
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(_ closer: @escaping (T)->Void){
        closer(value)
        listener = closer
    }
    
}
