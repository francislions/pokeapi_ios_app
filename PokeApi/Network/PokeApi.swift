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
        AF.request("\(Constants.PokemonAPI.BaseURL)/pokemon").responseDecodable(of: Pokemons.self) { response in
            guard let pokemons = response.value else {
                completion(nil)
                return
            }
            completion(pokemons)
        }
    }
    
    func getPokemon(_ id: String) {
        AF.request("\(Constants.PokemonAPI.BaseURL)/pokemon/\(id)").response { response in
            
        }
    }
}
