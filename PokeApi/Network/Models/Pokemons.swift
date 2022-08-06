//
//  Pokemons.swift
//  PokeApi
//
//  Created by Francesco Leoni on 06/08/22.
//

import Foundation


struct Pokemons: Decodable {
    let results: [PokemonListItem]
    let next: String
    
    enum CodingKeys: String, CodingKey {
        case results
        case next
    }
}
