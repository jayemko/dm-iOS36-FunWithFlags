//
//  Country.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import Foundation

struct Country : Decodable {
    let name: String
    let subregion: String
    let currencies: [Currency]
    let languages: [Language]
    let flag: URL
}

struct Currency : Decodable {
    let name: String?
}

struct Language : Decodable {
    let name: String
}
