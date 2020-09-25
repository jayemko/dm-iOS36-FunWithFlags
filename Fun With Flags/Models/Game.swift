//
//  Game.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import Foundation

class Game {
    let countries: [Country]
    let selectedInt: Int
    
    init(option1: Country, option2: Country, option3: Country, selectedInt: Int){
        countries = [option1,option2,option3]
        self.selectedInt = selectedInt
    }
}
