//
//  GameController.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import Foundation
import UIKit.UIImage

// Filter Response
// https://restcountries.eu/rest/v2/{service}?fields={field};{field};{field}
// ex: https://restcountries.eu/rest/v2/all?fields=name;capital;currencies

struct StringConstants {
    fileprivate static let baseURL = "https://restcountries.eu/rest/v2"
    fileprivate static let endpointAll = "all"
    fileprivate static let endpointName = "name"
    fileprivate static let querySubject = "fields"
    fileprivate static let queryItemName = "name"
    fileprivate static let queryItemFlag = "flag"
    fileprivate static let queryItemLanguages = "languages"
    fileprivate static let queryItemCurrency = "currencies"
    fileprivate static let queryItemSubregion = "subregion"
}

class GameController {
    
    var countries: [Country]?
    var game: Game?
    
    static var shared = GameController()
    
    func fetchCountries(completion: @escaping (Result<[Country], FlagError>) -> Void) {
        let baseURL = URL(string:StringConstants.baseURL)
        let endpointAllURL = baseURL?.appendingPathComponent(StringConstants.endpointAll)
        guard let finalURL = endpointAllURL else {return completion(.failure(.invalidURL))}
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.invalidData)) }
            do {
                let newCountries = try JSONDecoder().decode([Country].self, from: data)
                let countries = newCountries
                print("[\(#function): \(#line)] -- \(countries.count) countries")
                let shuffledCountries = countries.shuffled()
                let number = Int.random(in: 0...2)
                let newGame = Game(option1: shuffledCountries[0], option2: shuffledCountries[1], option3: shuffledCountries[3], selectedInt: number)
                self.game = newGame
                return completion(.success(countries))
            } catch {
                print("Error [\(#function):\(#line)] -- \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.invalidData))
            }
        }.resume()
    }
}
