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
    let pokeApi: PokeApi
    var pokemons: PublishSubject<[PokemonListItem]> = PublishSubject()
    var isLoading: PublishSubject<Bool> = PublishSubject()
    
    init(coordinator: PokemonListCoordinator, pokeApi: PokeApi = PokeApi()) {
        self.coordinator = coordinator
        self.pokeApi = pokeApi
        self.pokemons.onNext([])
        self.isLoading.onNext(false)
    }
    
    func loadInitialData() {
        self.isLoading.onNext(true)
        pokeApi.pokemonList(offset: 0, limit: 0) { pokemons in
            if let pokemons = pokemons {
                self.pokemons.onNext(pokemons.results)
            }
            self.isLoading.onNext(false)
        }
    }
    
    func showPokemonDetail(pokemonId: Int) {
        coordinator?.showPokemonDetail(pokemonId: pokemonId)
    }
}
