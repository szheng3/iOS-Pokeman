//
// Created by Shuai Zheng on 4/14/20.
// Copyright (c) 2020 Shuai Zheng. All rights reserved.
//

import Foundation
import Alamofire

typealias DownloadComplete = () -> ()

//class Pokes {
//
//
//    private var _name: String!
//    private var _pokedexId: Int!
//    private var _description: String!
//    private var _type: String!
//    private var _defense: String!
//    private var _height: String!
//    private var _weight: String!
//    private var _attack: String!
//    private var _nextEvolutionTxt: String!
//    private var _nextEvolutionName: String!
//    private var _nextEvolutionId: String!
//    private var _nextEvolutionLevel: String!
//    private var _pokemonURL: String!
//
//    var nextEvolutionLevel: String {
//
//        if _nextEvolutionLevel == nil {
//
//            _nextEvolutionLevel = ""
//        }
//        return _nextEvolutionLevel
//    }
//
//    var nextEvolutionId: String {
//
//        if _nextEvolutionId == nil {
//
//            _nextEvolutionId = ""
//        }
//        return _nextEvolutionId
//    }
//
//    var nextEvolutionName: String {
//
//        if _nextEvolutionName == nil {
//
//            _nextEvolutionName = ""
//        }
//        return _nextEvolutionName
//    }
//
//    var description: String {
//
//        if _description == nil {
//
//            _description = ""
//        }
//        return _description
//    }
//
//    var type: String {
//
//        if _type == nil {
//
//            _type = ""
//        }
//        return _type
//    }
//
//    var defense: String {
//
//        if _defense == nil {
//
//            _defense = ""
//        }
//        return _defense
//    }
//
//    var height: String {
//
//        if _height == nil {
//
//            _height = ""
//        }
//        return _height
//    }
//
//    var weight: String {
//
//        if _weight == nil {
//
//            _weight = ""
//        }
//        return _weight
//    }
//
//    var attack: String {
//
//        if _attack == nil {
//
//            _attack = ""
//        }
//        return _attack
//    }
//
//    var nextEvolutionText: String {
//
//        if _nextEvolutionTxt == nil {
//
//            _nextEvolutionTxt = ""
//        }
//        return _nextEvolutionTxt
//    }
//
//
//    var name: String {
//
//        return _name
//    }
//
//    var pokedexId: Int {
//
//        return _pokedexId
//    }
//
//    init(name: String, pokedexId: Int) {
//
//        self._name = name
//        self._pokedexId = pokedexId
//
////        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
//
//    }
//
//
//}


struct Pokes {

    var name: String
    var pokedexId: Int
}


struct PokesDetails: Codable {
    let abilities: [Ability]?
    let baseExperience: Int?
    let forms: [Species]?
    let gameIndices: [GameIndex]?
    let height: Int?
    let id: Int?
    let isDefault: Bool?
    let locationAreaEncounters: String?
    let moves: [Move]?
    let name: String?
    let order: Int?
    let species: Species?
    let sprites: Sprites?
    let stats: [Stat]?
    let types: [TypeElement]?
    let weight: Int?

}

// MARK: - Ability
struct Ability: Codable {
    let ability: Species?
    let isHidden: Bool?
    let slot: Int?
}

// MARK: - Species
struct Species: Codable {
    let name: String?
    let url: String?
}

// MARK: - GameIndex
struct GameIndex: Codable {
    let gameIndex: Int?
    let version: Species?
}

// MARK: - Move
struct Move: Codable {
    let move: Species?
    let versionGroupDetails: [VersionGroupDetail]?
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int?
    let moveLearnMethod, versionGroup: Species?
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int?
    let stat: Species?
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int?
    let type: Species?
}

class PokesService {
    var pokesDetails: PokesDetails?;
    static let shared = PokesService()


    func getData(pokeId: Int, completed: @escaping DownloadComplete) {
        AF.request("https://pokeapi.co/api/v2/pokemon/\(pokeId)").responseData { response in
            switch response.result {
            case .success:
                let json = response.data

                let jsonString = String(data: json!, encoding: .utf8)!;

                self.pokesDetails = try? JSONDecoder().decode(PokesDetails.self, from: response.data!)
            case let .failure(error):
                print(error)
            }

            completed()

        }
    }

}