//
//  PokemonListItem.swift
//  PokeApi
//
//  Created by Francesco Leoni on 06/08/22.
//

import Foundation

struct PokemonListItem: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
