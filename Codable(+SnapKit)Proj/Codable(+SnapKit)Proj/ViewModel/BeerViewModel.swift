//
//  BeerViewModel.swift
//  Codable(+SnapKit)Proj
//
//  Created by 이경후 on 2021/12/28.
//

import Foundation
import SwiftUI

class BeerViewModel {
    
    var id = Observable(1)
    var imageURL = Observable("")
    var tagLine = Observable("")
    var name = Observable("")
    var beerDescription = Observable("")
    var foodPairing = [Observable("")]
    var foodPairingCnt = Observable(1)
    
    func fetchBeerAPI(_ beerId : Int){
        
        PunkAPI.fetchData(beerId) { beer in
            guard let beer = beer else {
                return
            }
            
            self.id.value = beer.id
            self.name.value = beer.name
            self.imageURL.value = beer.imageURL
            self.tagLine.value = beer.tagline
            self.beerDescription.value = beer.beerDescription
            self.foodPairingCnt.value = beer.foodPairing.count

            for item in 0...beer.foodPairing.count - 1 {
                self.foodPairing.append(Observable(""))
                self.foodPairing[item].value = beer.foodPairing[item]
            }
        }
    }
}
