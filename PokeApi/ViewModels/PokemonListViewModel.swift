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
    private var numberOfPokemons: Int = 0
    let pokeApi: PokeApi
    var pokemons: BehaviorSubject<[PokemonListItem]> = BehaviorSubject(value: [])
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init(coordinator: PokemonListCoordinator, pokeApi: PokeApi = PokeApi()) {
        self.coordinator = coordinator
        self.pokeApi = pokeApi
    }
    
    func loadInitialData(offset: Int = 0) {
        self.isLoading.onNext(true)
        pokeApi.pokemonList(offset: offset, limit: Constants.PokemonAPI.PokemonListLimit) { pokemons in
            if let pokemons = pokemons, let oldPokemons = try? self.pokemons.value() {
                let pokemonArray = oldPokemons + pokemons.results
                self.numberOfPokemons = pokemons.count
                self.pokemons.onNext(pokemonArray)
            }
            self.isLoading.onNext(false)
        }
    }
    
    func showPokemonDetail(pokemonId: Int) {
        coordinator?.showPokemonDetail(pokemonId: pokemonId)
    }
    
    func loadMoreData() {
        let offset = (try? self.pokemons.value().count) ?? 0 + 1
        if offset < numberOfPokemons {
            loadInitialData(offset: offset)
        }
    }
}
