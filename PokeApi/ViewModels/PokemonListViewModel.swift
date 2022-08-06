//
//  PokemonListViewModel.swift
//  PokeApi
//
//  Created by Francesco Leoni on 05/08/22.
//

import Foundation
import RxSwift

final class PokemonListViewModel {
    private weak var coordinator: PokemonListCoordinator?
    let pokeApi = PokeApi()
    var pokemons: PublishSubject<[PokemonListItem]> = PublishSubject()
    
    init(coordinator: PokemonListCoordinator) {
        self.coordinator = coordinator
        self.pokemons.onNext([])
    }
    
    func loadInitialData() {
        pokeApi.pokemonList(offset: 0, limit: 0) { pokemons in
            if let pokemons = pokemons {
                self.pokemons.onNext(pokemons.results)
            }
        }
    }
}
