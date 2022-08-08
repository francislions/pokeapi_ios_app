//
//  PokeApi.swift
//  PokeApi
//
//  Created by Francesco Leoni on 06/08/22.
//

import Foundation
import Alamofire

class PokeApi {
    func pokemonList(offset: Int, limit: Int, completion: @escaping (Pokemons?) -> Void) {
        let parameters = ["offset": offset, "limit": limit]
        AF.request("\(Constants.PokemonAPI.BaseURL)/pokemon", parameters: parameters).responseDecodable(of: Pokemons.self) { response in
            guard let pokemons = response.value else {
                completion(nil)
                return
            }
            completion(pokemons)
        }
    }
    
    func getPokemon(_ id: Int, completion: @escaping (Pokemon?) -> Void) {
        AF.request("\(Constants.PokemonAPI.BaseURL)/pokemon/\(id)").responseDecodable(of: Pokemon.self) { response in
            guard let pokemon = response.value else {
                completion(nil)
                return
            }
            completion(pokemon)
        }
    }
}
