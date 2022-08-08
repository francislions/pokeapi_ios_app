//
//  Pokemon.swift
//  PokeApi
//
//  Created by Francesco Leoni on 06/08/22.
//

import Foundation

struct Pokemon: Decodable {
    var id: Int
    var name: String
    var sprites: PokemonSprites
    var types: [PokemonSlotType]
    var stats: [PokemonBaseStat]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case sprites
        case types
        case stats
    }
}

struct PokemonSprites: Decodable {
    var frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonBaseStat: Codable {
    var baseStat: Int
    var effort: Int
    var stat: PokemonStat
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonStat: Codable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct PokemonSlotType: Decodable {
    var slot: Int
    var type: PokemonType
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
}

struct PokemonType: Decodable {
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
